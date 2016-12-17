import tensorflow as tf


def tf_mean_logloss(raw_margins, target_values, tag, trunc_max=100):
    # -y*f(x)
    myfx = -1*tf.mul(target_values, raw_margins)
    elementwise_logloss = tf.log(1 + tf.exp(myfx), name='elwise_' + tag)
    checked_elwise_loss = tf.verify_tensor_all_finite(elementwise_logloss, msg='NaN or Inf in loss vector', name='checked_elwise_loss')
    mean_loss = tf.reduce_mean(tf.minimum(checked_elwise_loss, trunc_max), name='mean_' + tag)
    return mean_loss


def tf_mean_l2(w):
    elementwise_sq_norm = tf.reduce_sum(tf.pow(w, 2), axis=1)
    checked_elwise_l2 = tf.verify_tensor_all_finite(elementwise_sq_norm, msg='NaN or Inf in norm', name='checked_elwise_l2')
    mean_l2 = tf.reduce_mean(checked_elwise_l2)
    return mean_l2


class BPR_MF(object):

    def __init__(self, n_users, n_items, n_embeddings, alpha_reg=0, seed=None):
        self.N_USERS = n_users
        self.N_ITEMS = n_items
        self.N_EMBEDDINGS = n_embeddings
        self.alpha_reg = alpha_reg
        self.seed = seed
        self.graph = tf.Graph()
        if seed:
            self.graph.seed = seed


    def build_graph(self):
        with self.graph.as_default():
            # placeholders
            self.user_ids = tf.placeholder(tf.int32, (None,), name='user_ids')
            self.left_ids = tf.placeholder(tf.int32, (None,), name='left_ids')
            self.right_ids = tf.placeholder(tf.int32, (None,), name='right_ids')
            self.target_y = tf.placeholder(tf.float32, (None,), name='target_y')

            # main parameters
            self.user_latents = tf.Variable(tf.random_uniform(shape=(self.N_USERS, self.N_EMBEDDINGS)), trainable=True, name='user_latents')
            self.item_latents = tf.Variable(tf.random_uniform(shape=(self.N_ITEMS, self.N_EMBEDDINGS)), trainable=True, name='item_latents')

            # get embeddings for batch
            self.embedding_user = tf.nn.embedding_lookup(self.user_latents, self.user_ids, name='embedding_user')
            self.embedding_left = tf.nn.embedding_lookup(self.item_latents, self.left_ids, name='embedding_left')
            self.embedding_right = tf.nn.embedding_lookup(self.item_latents, self.right_ids, name='embedding_right')

            # raw margins for primal ranking loss
            self.embedding_diff = self.embedding_left - self.embedding_right

            # shape: [n_batch, ]
            self.embedding_margins = tf.reduce_sum(tf.mul(self.embedding_user, self.embedding_diff), axis=1, name='embedding_margins')
            self.embedding_loss = tf_mean_logloss(self.embedding_margins, self.target_y, 'embedding_loss')

            # outs
            self.regularization = tf_mean_l2(self.embedding_user) + tf_mean_l2(self.embedding_left) + tf_mean_l2(self.embedding_right)
            self.target = self.embedding_loss + self.alpha_reg * self.regularization

            self.trainer_1 = tf.train.AdamOptimizer(learning_rate=0.05).minimize(self.target)
            self.trainer_2 = tf.train.AdamOptimizer(learning_rate=1e-2).minimize(self.target)
            self.trainer_3 = tf.train.AdamOptimizer(learning_rate=1e-3).minimize(self.target)
            self.init_all_vars = tf.global_variables_initializer()
            # self.saver = tf.train.Saver()

    @property
    def weights_i(self):
        return self.user_latents.eval(session=self.session)

    @property
    def weights_u(self):
        return self.item_latents.eval(session=self.session)


    def initialize_session(self):
        config = tf.ConfigProto()
        # for reduce memory allocation
        config.gpu_options.allow_growth = True
        self.session = tf.Session(graph=self.graph, config=config)
        self.session.run(self.init_all_vars)

    def destroy(self):
        self.session.close()
        self.graph = None