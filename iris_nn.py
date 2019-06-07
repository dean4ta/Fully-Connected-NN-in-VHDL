#Dean Fortier

from __future__ import absolute_import, division, print_function

# TensorFlow and tf.keras
import tensorflow as tf
from tensorflow import keras

# Helper libraries
import numpy as np
import matplotlib.pyplot as plt

print(tf.__version__)


# 0 - setosa
# 1 - versicolor
# 2 - virginica
class_names = ['setosa', 'versicolor', 'virginica']

data = np.genfromtxt('iris_raw.csv', delimiter = ',')
#print('data', type(data), '\n', data)

train_data = np.concatenate((data[0:40,:4], data[50:90,:4], data[100:140,:4]), axis=0)
#print(train_data.shape, train_data)
train_labels = np.concatenate((data[0:40,4], data[50:90,4], data[100:140,4]), axis=0)
#print(train_labels.shape, train_labels)
test_data = np.concatenate((data[40:50,:4], data[90:100,:4], data[140:150,:4]), axis=0)
test_labels = np.concatenate((data[40:50,4], data[90:100,4], data[140:150,4]), axis=0)


'''
Setup the layers

The network consists of a sequence of two 
tf.keras.layers.Dense layers. These are densely-connected, or fully-connected, 
neural layers. The first Dense layer has 128 nodes (or neurons). The second (and 
last) layer is a 10-node softmax layer—this returns an array of 10 probability scores 
that sum to 1. Each node contains a score that indicates the probability that the 
current image belongs to one of the 10 classes.
'''
'''
input layer    => 4  inputs
hidden layer 1 => 10 neurons, 4  inputs per neuron
hidden layer 2 => 8  neurons, 10 inputs per neuron
output layer   => 3  neurons, 8  inputs per neuron
'''
no_inputs     = 4
no_neurons_h1 = 10
no_neurons_h2 = 8
no_outputs    = 3
model = keras.Sequential([
	keras.layers.Dense(no_neurons_h1, activation = tf.nn.sigmoid, use_bias=False, input_shape=(no_inputs,)), #hidden1
	keras.layers.Dense(no_neurons_h2, activation = tf.nn.sigmoid, use_bias=False), #hidden2
	keras.layers.Dense(no_outputs, activation = tf.nn.sigmoid, use_bias=False) #output
])


'''
Compile the model

Before the model is ready for training, it needs a few more settings. These are 
added during the model's compile step:

- Loss function —This measures how accurate the model is during training. We 
	want to minimize this function to "steer" the model in the right direction.
- Optimizer —This is how the model is updated based on the data it sees and its 
	loss function.
- Metrics —Used to monitor the training and testing steps. The following example 
	uses accuracy, the fraction of the images that are correctly classified.
'''
model.compile(optimizer='rmsprop', 
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

'''
Train the model

Training the neural network model requires the following steps:

1. Feed the training data to the model—in this example, the train_images and 
	train_labels arrays.
2. The model learns to associate images and labels.
3. We ask the model to make predictions about a test set—in this example, the 
	test_images array. We verify that the predictions match the labels from the 
	test_labels array.
'''
model.fit(train_data, train_labels, epochs=200)

'''
Evaluate accuracy

compare how model performs on test dataset
'''
test_loss, test_acc = model.evaluate(test_data, test_labels)

print('Test accuracy:', test_acc)

'''
Make predictions

predict class of particular image
'''
predictions = model.predict(test_data)

# looking at first prediction
print('prediction[0]', np.argmax(predictions[0]), predictions[0])
print('test_labels[0]', test_labels[0])

for layer in model.layers:
	weights = layer.get_weights()
	print('\n-----------------------------------')
	print("weights at layer  ", layer.get_config()['name'])
	print('length of weights', len(weights))
	for i in range(len(weights)):
		print("weights["+str(i)+']')
		print("neuron input size:", len(weights[0]))
		print("number of neurons:", len(weights[0][0]))
		print(weights[i])
		if layer.get_config()['name'] == 'dense':
			stringName = 'layer_h1 neruons_'+str(no_neurons_h1)+' inputsPerNeuron_'+str(no_inputs)+'.csv'
		elif layer.get_config()['name'] == 'dense_1':
			stringName = 'layer_h2 neruons_'+str(no_neurons_h2)+' inputsPerNeuron_'+str(no_neurons_h1)+'.csv'
		elif layer.get_config()['name'] == 'dense_2':
			stringName = 'layer_out neruons_'+str(no_outputs)+' inputsPerNeuron_'+str(no_neurons_h2)+'.csv'
		np.savetxt(stringName, weights[0], delimiter=',')

