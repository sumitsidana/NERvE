import tensorflow as tf
import tensorflow.contrib.slim as slim


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


# #Mikhail: I suggest to move the definition of inner net outside of this file
# def inner_network(user_emb, item_emb):
#     joined_input = tf.concat(1, [user_emb, item_emb])
#     net = slim.fully_connected(inputs=joined_input, num_outputs=64, activation_fn=tf.nn.relu)
#     net = slim.fully_connected(inputs=net, num_outputs=1, activation_fn=None)
#     return net


class BPR_NN_WO_EMB(object):

    def __init__(self, inner_net, alpha_reg=0, seed=None):
        assert inner_net is not None, 'inner_net param should be None'
        self.alpha_reg = alpha_reg
        self.seed = seed
        self.graph = tf.Graph()
        self.inner_net = inner_net
        if seed:
            self.graph.seed = seed

    def build_graph(self):
        with self.graph.as_default():
            # placeholders
            self.user_ids = tf.placeholder(tf.int32, (None,), name='user_ids')
            self.left_ids = tf.placeholder(tf.int32, (None,), name='left_ids')
            self.right_ids = tf.placeholder(tf.int32, (None,), name='right_ids')
            self.target_y = tf.placeholder(tf.float32, (None,), name='target_y')
            self.target_diff = tf.placeholder(tf.float32, (None,), name='target_diff')

            # apply shared net
            with tf.variable_scope("nn"):
                self.left_output = self.inner_net(self.user_ids, self.left_ids)
            with tf.variable_scope("nn", reuse=True):
                self.right_output = self.inner_net(self.user_ids, self.right_ids)

            # margins for net output
            self.net_margins = self.left_output - self.right_output
            # shape: [n_batch, 1] -> [n_batch, ]
            self.net_margins = tf.squeeze(self.net_margins, axis=1, name='net_margins')
            self.net_loss = tf_mean_logloss(self.net_margins, self.target_y, 'net_loss')

            # outs
            self.regularization = 0
            self.ranking_losses = self.net_loss
            self.target = self.ranking_losses + self.alpha_reg * self.regularization

            # different trainers, by default use _3
            self.trainer_1 = tf.train.AdamOptimizer(learning_rate=0.05).minimize(self.target)
            self.trainer_2 = tf.train.AdamOptimizer(learning_rate=1e-2).minimize(self.target)
            self.trainer_3 = tf.train.AdamOptimizer(learning_rate=1e-3).minimize(self.target)
            self.trainer_4 = tf.train.AdamOptimizer(learning_rate=1e-4).minimize(self.target)
            self.init_all_vars = tf.global_variables_initializer()

    @property
    def weights_i(self):
        return self.item_latents.eval(session=self.session)

    @property
    def weights_u(self):
        return self.user_latents.eval(session=self.session)

    def initialize_session(self):
        config = tf.ConfigProto()
        # for reduce memory allocation
        config.gpu_options.allow_growth = True
        self.session = tf.Session(graph=self.graph, config=config)
        self.session.run(self.init_all_vars)

    def destroy(self):
        self.session.close()
        self.graph = None