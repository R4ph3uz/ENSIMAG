---
title: "Formulaire de réponse pour le test 1"
output: html_document
author: Raphael Euzeby
---

** **

##### Raphaël Euzeby Groupe 7

##### Question 1

* Déterminer l'espérance du nombre de candidats réussissant l'examen.

###### Réponse : 
___
**196 personnes**

C'est l'éspérance d'une loi binomiale : répétition indépendante pour chaque étudiant qu'il réussisse pour chaque épreuve
$\rm E=240*(1-0.02)^{10}\simeq196$ 
___
##### Question 2

* Calculer les probabilités P($N = i$), pour tout $i$ de 1 à 4.  

###### Réponse : 
___
**P($N = i$) =$\frac{i}{10}$**

$\rm P(N=i)=P(N_2=i|N_1<=i)=\frac{P(N_2=i \cap N_1\leq i)}{P(N_1\leq N_2)}$ par la formule des probabilités conditionelle

$\rm P(N=i)=\frac{P(N_2=i)P(N_1\le i)}{P(\cup_{k=1}^4 (N_2=k \cap N_1\le k))}$ par indépendance de $N_1$ et $N_2$ et comme l'union est disjointe

$\rm P(N=i)=\frac{P(N_2=i)P(N_1\le i)}{\sum_{k=1}^4 P(N_2=k \cap N_1\le k)}=\frac{P(N_2=i)P(N_1\le i)}{\sum_{k=1}^4 P(N_2=k)P(N_1\le k)}=\frac{\frac{1}{4}\frac{i}{4}}{\frac{1}{4}(\frac{1}{4}+\frac{2}{4}+\frac{3}{4}+\frac{4}{4}+)}=\frac{i}{10}$
___
##### Question 3

* Calculer la probabilité de l'événement $G$ sachant que le candidat change de porte. Calculer la probabilité de l'événement $G$ sachant que le candidat conserve son choix initial.

###### Réponse : 
___
**P(G|P)=$\frac{2}{3}$ et P(G|$\overline{P}$ )=$\frac{1}{3}$**

On définit G : "le candidat ouvre finalement la bonne porte et gagne le jeu".

I : "choisit la bonne porte initialement"

C : "le joueur change de porte"

P1 : "le joueur a choisit une porte qui perd"

P2 : "le joueur choisit la deuxième porte qui perd"

P : "le joueur choisit une porte qui perd"

On a $P=P1 \cup P2$

$\rm P(G)=P(P1)=P(P2)=\frac{1}{3}$

donc $P(P) =\frac{2}{3}$

$\rm P_c(G|P) = 1$ est la probabilité qu'il gagne en changeant de porte sachant qu'il était sur une porte perdante; ce qui est certain

$\rm P_c(G|I) = 0$ est la probabilité que le joueur gagne en changeant de porte sachant qu'il a choisit initialement la bonne porte, cela est irréalisable.

Dans le cas du changement de porte ( noté $P_c$ )

$\rm P_c(G)= P_c(G|P)P(P)+P_c(G|I)P(I)=1*\frac{2}{3}+0*\frac{1}{3}=\frac{2}{3}$

$\rm P_{\overline{c}}(G)= P_{\overline{c}}(G|P)P(P)+P_{\overline{c}}(G|I)P(I)=0*\frac{2}{3}+1*\frac{1}{3}=\frac{1}{3}$

___
##### Question 4

* Le candidat opte a priori pour une stratégie aléatoire. Il change de porte avec la probabilité $p = 1/3$. Puis il joue et gagne le jeu. Quelle est la probabilité que le candidat ait changé de porte ?

###### Réponse : 
___
**P(C|G)=$\frac{3}{5}$**

$\rm P(C|G)=\frac{P(C\cap G)}{P(G)}=\frac{P(G|C)P(C)}{P(G)}=\frac{P(G|C)P(C)}{P(G|C)P(C)+P(G|\overline{C})P(\overline{C})}$ par la formule des probabilités totales.

ainsi $\rm P(C|G)=\frac{\frac{2}{3}\frac{1}{3}}{2/9 +1/3 * 2/3}=\frac{1}{2}$
___
##### Question 5

* Calculer la valeur médiane de la variable $X$.  

###### Réponse : 
___
**P(X<K)=0.5 donc la mediane de X est k**

on cherche k, tel que $P(X<k)=0.5$

$\rm P(u*N<k)=P(u*N<k|N=1)P(N=1)+P(u*N<k|N=2)P(N=2)+P(u*N<k|N=3)P(N=3)$
par probabilité totale

$\rm P(u*N<k)=P(u<k|N=1)P(N=1)+P(u*2<k|N=2)P(N=2)+P(u*3<k|N=3)P(N=3)=\frac{k}{2}+P(u<\frac{k}{2}|N=2)*\frac{1}{3}+P(u<\frac{k}{3}|N=3)\frac{1}{6}=\frac{k}{2}+\frac{k}{2}*\frac{1}{3}+\frac{k}{3}*\frac{1}{6}$

on cherche que cela soit égal à $\frac{1}{2}$

d'où $k=\frac{9}{13}$

___
##### Question 6

* Calculer la probabilité de l'événement $(Z_N > 1)$  

###### Réponse : 
___
**$P(Z_N>1)=e^{-1}(e^{e^{-\mu}}-1)$**

On a $\forall i \in [1;n]  P(X_i>t)=exp(-\mu t)$

$\rm P(Z_n>t)=P(min_{i \in [1;n]}(X_i)>t)=P(X_1>t \cap X_2>t \cap ... \cap X_n>t)$ comme les X_i sont indépendants

$\rm P(Z_n>t)=P(X_1>t)P(X_2>t)...P(X_n>t)=exp(-n\mu t)$

P(N)

$\rm P(Z_N>1)=P(\bigcup_{i=1}^{\infin} (Z_N>1 \cap N=i))=\sum_{i=1}^{\infin}P(Z_i>1 | N=i)P(N=i)=\sum_{i=1}^{\infin}exp(-i\mu)* \frac{1^i}{i!}e^{-1}=e^{-1}\sum_{i=1}^{\infin}\frac{(e^{-\mu})^i}{i!}=e^{-1}(e^{e^{-\mu}}-1)$
___
##### Question 7

* Déterminer la loi de la variable $Z$. Donner son espérance.

###### Réponse : 

___
**Z suit une loi binomiale de paramètre (20,8/9) et son espérance est d'environ 18** 

On définie $A_i$ : "le tireur touche la cible au ième tir"

Z est une répetition d'evenement indépendant : pour chaque tireur, la flèche touche au premier lancé ou la flèche touche au deuxième lancé.

or la flèche touche en suivant une loi de bernouilli de paramètre 2/3

donc la seule possibilité (non autorisée) est lorsque la flèche ne touche pas la cible avec une probabilité (1-p)*(1-p) soit ici 1/3 * 1/3 =1/9. Donc p =1-1/9 =8/9

donc Z suit une loi binomiale de paramètre n=20, p=8/9.

___

##### Question 8

* Déterminer la loi de la variable $Y$. Donner son espérance.

###### Réponse : 

** **
on répète n=20 fois le fait que le tireur loupe son premier tir puis touche au second : Y suit une loi binomiale de paramètre n, 2/3*(1-2/3)=2/9  
$\pi_{k,l}=P(Y=l|X=k)=(_{\,\,\,\,l}^{n-k})p^l(1-p)^{n-k-l}$

$E(Y)=20*2/9\simeq 4.4$
___

##### Question 9

* Donner une relation simple liant ${\rm E}[XY]$ à l'espérance d'une fonction simple de $X$ et la valeur de cette espérance (une ligne). 

###### Réponse : 

** **
en utilisant la question d'après et cette formule : cov(X,Y)=E(X)E(Y)-E(XY)  

on a ainsi $E(XY)=E(X)E(Y)-cov(X,Y)$

E(XY)=$\frac{13529}{243}\simeq 56$

___

##### Question 10

* Calculer la variance de la variable aléatoire $Z$. En déduire la covariance du couple $(X,Y)$ et retrouver le résultat précédent (une ligne). 
   
###### Réponse : 
___

Z suit une loi binomiale donc la variance est np(1-p) ou p est la probabilité associée à Z, ici 8/9

V(Z)=$\frac{160}{81} \simeq 4$

$V(Z)=V(X+Y)=V(X)+V(Y)+2cov(X,Y)$

donc

$Cov(X,Y)=\frac{1}{2}(V(Z)-V(X)-V(Y))=\frac{1}{2}( 160/81-40/9 -280/81)=-\frac{80}{27}\simeq -3$
___

