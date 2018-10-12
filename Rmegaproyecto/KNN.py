# import the necessary packages
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def main():
	dataset_path = 'Data.csv'
	#Data
	#Iteraciones para entrenamiento
	model_result= create_model(27)
	iterations = 20 
	acc_array= []
	arr_seeds = seed_name(iterations)

	for i in range(iterations):
		seed_name_r = arr_seeds[i]
		dataset_return = load_data_set(dataset_path, seed_name_r)
		model_result, result_acc = training(dataset_return, model_result, iterations)
		acc_array.append(result_acc)
	prediction_result = predict([[43.25, -17.35, 7.12,-27.35,-0.103149,0.135681,-34.4]], model_result)
	plot_acc(acc_array)
	print (prediction_result)


# Import Dataset (esto uso yo para importar CSVs a arrays)
def load_data_set(path, seed):
	data = pd.read_csv(path, sep=',')
	X = data.values[:, :7]
	y = data.values[:, 7]
	print(data.head())
	# crea los datasets
	(x_train, x_test, y_train, y_test) = train_test_split(X, y, test_size=0.30, random_state=seed)
	return x_train, x_test, y_train, y_test

def create_model(neighbors_in):
	
	# los datos tienen que estar en arrays de numpy, de la manera de abajo convierte array normal a numpy si no lo hace como arriba
	# ------------------------------------------
	# Scikit Learn Implementation
	# ------------------------------------------
	# k-NN
	return KNeighborsClassifier(n_neighbors=neighbors_in) #el classificador
	 
def training(data_input, model, iterations):


	#Extraer los datos
	x_train = data_input[0]
	x_test = data_input[1]
	y_train = data_input[2] 
	y_test = data_input[3]

	model.fit(x_train, y_train) # entrenar el modelo
	acc = model.score(x_test, y_test) # accuracy
	print (acc)
	return model, acc

def predict(array_to_predict,model):
	array_eval=np.array(array_to_predict)
	prediction = model.predict(array_eval)
	return prediction

def plot_acc(array_to_plot):
	plt.plot(array_to_plot, 'k-', label='Accuracy')
	plt.title('Batch Accuracy')
	plt.xlabel('Generation')
	plt.ylabel('Accuracy')
	plt.legend(loc='lower right')
	plt.show()

def seed_name(iterations):
	array_gen = []
	for i in range(iterations):
		array_gen.append(i)

	return array_gen

if __name__ == '__main__':
	main()