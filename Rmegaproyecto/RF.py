# import the necessary packages
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
import matplotlib.pyplot as plt
from sklearn import metrics
import numpy as np
import pandas as pd
import pickle

def main():
	dataset_path = 'Data.csv'
	#Data
	#Iteraciones para entrenamiento
	model_result= create_model(100)
	iterations = 100
	acc_array= []
	arr_seeds = seed_name(iterations)
	array_model = []

	for i in range(iterations):
		seed_name_r = arr_seeds[i]
		dataset_return = load_data_set(dataset_path, seed_name_r)
		model_result, result_acc = training(dataset_return, model_result, iterations)
		#arrays con accuracy y modelos 
		acc_array.append(result_acc)
		array_model.append(model_result)
	#buscar el mejor acc para utilizar este modelo en prediccion
	best_acc = acc_array.index(max(acc_array))
	best_model = array_model[best_acc]
	pkl_filename = "pickle_RF.pkl"
	with open(pkl_filename, 'wb') as file:
		pickle.dump(best_model, file)
	print ("best",best_model)
	print(acc_array)

# Import Dataset (esto uso yo para importar CSVs a arrays)
def load_data_set(path, seed):
	data = pd.read_csv(path, sep=',')
	X = data.values[:, :7]
	y = data.values[:, 7]
	print(data.head())
	# crea los datasets
	(x_train, x_test, y_train, y_test) = train_test_split(X, y, test_size=0.30, random_state=seed)
	return x_train, x_test, y_train, y_test

def create_model(estimadores):
	
	# los datos tienen que estar en arrays de numpy, de la manera de abajo convierte array normal a numpy si no lo hace como arriba
	# ------------------------------------------
	# Scikit Learn Implementation
	# ------------------------------------------
	# Random Forest
	return RandomForestClassifier(n_estimators=estimadores) #el classificador
	 
def training(data_input, model, iterations):


	#Extraer los datos
	x_train = data_input[0]
	x_test = data_input[1]
	y_train = data_input[2] 
	y_test = data_input[3]

	model.fit(x_train, y_train) # entrenar el modelo
	acc = model.score(x_test,y_test)
	#acc = model.score(x_test, y_test) # accuracy
	print (acc)
	return model, acc

def predict(array_to_predict,model):
	array_eval=np.array(array_to_predict)
	prediction = model.predict(array_eval)
	return prediction

def seed_name(iterations):
	array_gen = []
	for i in range(iterations):
		array_gen.append(i)

	return array_gen

if __name__ == '__main__':
	main()