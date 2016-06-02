# Deep-Learning

Deep Learning group project : Dan Constantini ([github profile](https://github.com/constantinidan)), Tom Hayat ([github profile](https://github.com/tomhayat)) and Alexandre Attia

CNN are now very popular thanks to their ability to perform AI tasks such as object recognition. Our study focusses on Deep Architectures.  A first step is to truncate pretrained deep neural networks, add a classifier or another neural network and observe the accuracy.

![alt tag](https://github.com/alexattia/Deep-Learning/blob/master/poster.png)
-- French

Les réseaux de neurones à convolution sont devenus très populaires depuis quelques années grâce à leur précision et utilisation dans des tâches d'intelligence comparable à celles que l'humain fait tous les jours. Reconnaître un objet dans une image est un exemple de tâche. On distingue les réseaux normaux des réseaux profonds, dont le nombre de couches est supérieure à 3 convolutions. 
Notre étude port sur la profondeur des réseaux et l'impact sur la précision du réseaux.

Une première étape du projet a été d'utiliser des réseaux pré-entraînés puis des réseaux que nous avons entraînés. Nous nous sommes particulièrement intéreressé au réseau Neural in Network, adapté par Sergey Zagoruyko. Nous avons utilisé ce réseau pour une base de données que nous avons données (une partie des images 10 classes d'ImageNet). Puis nous l'avons tronqué à différents endroits pour y ajouter plusieurs classifieurs.

Notre étude a donc été de comparer l'influence des classifieurs (régression logistique, SVM, Convolution+LogSoftMax) pour différentes profondeurs afin de comprendre le besoin de profondeur (par rapport par exemple à la largeur) d'un réseau de neurones.

