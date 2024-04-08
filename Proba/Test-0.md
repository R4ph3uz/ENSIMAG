---
title: "Formulaire de réponse pour le test 0 -- TD-1"
output: pdf_document
---

** **

$\dash$

#### Problème 1 

##### Question 1

* Déterminer la probabilité de l'événement $(N_E > k)$, pour tout $k \geq 1$. Quelle est la loi de $N_E$ ?

###### Réponse : 

$P(N_E > k) = 1- P(N_E\leq k)=1- P(\bigcup_{j=1}^{k} N_E=j) = 1-\sum_{j=1}^{k}P(N_E=j)$ or $P(N_E = j)$ correspond au fait que au jème tour le premier 1 soit tiré $P(N_E=j)=p(1-p)^{j-1}$ où p est la probabilité d'avoir un 1 ici $\frac{1}{6}$.
donc $P(N_E>k)=1-\sum_{j=1}^{k}p(1-p)^{j-1}=1-p\sum_{j=0}^{k-1}(1-p)^j=1-p\frac{1-(1-p)^k}{p}=(1-p)^k$ or p=1/6 donc $P(N_E>k)=(\frac{5}{6})^k$

$N_E$ suit une loi Géométrique de paramètre 1/6

##### Question 2

* Calculer la probabilité de l'événement $(N > k)$, pour tout $k \geq 1$. Quelle est la loi de $N$ ?

###### Réponse :

$P(N > k) = P(N_E>k \cap N_R>k)$ or le fait d'avoir un 1 pour Eva ou un 1 pour Raph' est indépendant donc $P(N_E>k \cap N_R>k)=P(N_E>k)*P(N_R>k)=(\frac{5}{6})^k * (\frac{6}{7})^k = (\frac{5}{7})^k$

##### Question 3

* Quelle est la probabilité pour que Eva gagne ? 

###### Réponse : 

# Q3 & Q5 & EX 3
$P(N_E<N_R)=P(\bigcup_{m=2}^{+\infin}(\bigcup_{k=1}^{m-1}(N_E=k\cap N_R=m)))=\sum_{m=2}^{+\infin}    \sum_{k=1}^{m-1} p_E$

##### Question 4

* Quelle est la probabilité de match nul ?


###### Réponse : 

$P(N_R=N_E)=P(\bigcup_{k=1}^{+\infin}(N_E=k \cap N_R=k)=\sum_{k=1}^{+\infin}P(N_E=k)*P(N_R=k)$ car $N_E$ et $N_R$ sont indépendants, on note $p_E$ (resp $p_R$) la probabilité que Eva (resp Raph') aie un 1
$P(N_R=N_E) =\sum_{k=1}^{+\infin}p_E(1-p_E)^{k-1}*p_R(1-p_R)^{k-1} = p_Ep_R\sum_{k=0}^{+\infin}(1-p_E)^k(1-p_R)^k=p_Ep_R*\frac{1}{1-(1-p_E)(1-p_R)}=\frac{1*1*1}{6*7*(1-\frac{5*6}{6*7})}=\frac{1}{12}$

##### Question 5

* Calculer la probabilité que la partie a duré moins de 3 manches sachant qu'Eva a gagné.


###### Réponse : 


** **

#### Problème 2


  
##### Question 1

*  Calculer la probabilité que la variable aléatoire $W$ soit inférieure ou égale à $1/3$.  

###### Réponse : 

  $P(W\leq\frac{1}{3})=P(W\leq\frac{1}{3}| W=V)P(W=V) +P(W\leq\frac{1}{3}|W=\sqrt{V})P(W=\sqrt{V})=P(V\leq\frac{1}{3})P(U\in[0;1/4[) +P(V\leq\frac{1}{9})*P(U\in[1/4;1[ U \text{\{}1 \text{\}})=\frac{1*1}{3*4}+\frac{1*3}{9*4} =\frac{1}{6}$

##### Question 2

*  Calculer l'espérance de la variable aléatoire $W^2$.  

###### Réponse : 

** E(W²)=1/4 ** car

$E(W²) = E(W² |U\in[0;1/4[)P(U\in[0;1/4[)+ E(W² |U\in[1/4;1[)P(U\in[1/4;1[U \text{\{}1 \text{\}})=E(V²)*1/4+E(V)*1/4$.

V suit une loi uniforme , donc son esperance est 1/2.
De même comme $x|-->x²$ est une bijection de [0;1] dans [0;1], L'esperance de V qui suit une loi uniforme sur [0;1] est la même que V² qui suit une loi uniforme sur [0;1] ainsi E(V²)=E(V)=1/2

E(W²)=1/4

#### Problème 3 


##### Question 1

*  Calculer l'espérance de la variable aléatoire $Z$.  

###### Réponse : 
