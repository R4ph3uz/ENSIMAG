---
title: "Formulaire de réponse pour le test 2"
output: pdf_document
author: EUZEBY Raphael
---

** **

##### Raphaël Euzèby G7

##### Question 1

* Calculer la probabilité de battre un record à l'épreuve $m$

###### Réponse :

$P(X_m>max_{i<m}X_i)=\frac{1}{m}$

$P(X_m>max_{i<m}X_i)=\int_{-\infin}^\infin P(x>max_{i<m}X_i | X_m=x)f_{X_m}(x)dx=\int_{-\infin}^\infin P(\bigcap_{i=1}^{m-1} x>X_i | X_m=x)f_{X_m}(x)dx=\int_{-\infin}^\infin \Pi_{i=1}^{m-1} P(x>X_i | X_m=x)f_{X_m}(x)dx=\int_{-\infin}^\infin P(X_i<x)^{m-1}f_{X_m}(x)dx=\int_{-\infin}^\infin (F_{X_i}(x))^{m-1}f_{X_m}(x)dx=[\frac{F(x)^m}{m}]_{-\infin}^\infin$

or $lim_{x\rightarrow-\infin}F(x)=0$ et $lim_{x\rightarrow\infin}F(x)=1$

d'où $P(X_m>max_{i<m}X_i)=\frac{1}{m}$

##### Question 2

* Donner l'espérance de $N$ pour $n = 27$. 

###### Réponse : 

$$E[N]=\sum_{m=1}^n \frac{1}{m}$$

On a $N=\sum_{m=1}^n \mathbb{1}_{Xm>max_{i<m}(X_{i})}$.

$E[N]=E[\sum_{m=1}^n \mathbb{1}_{Xm>max_{i<m}(X_{i})}]=\sum_{m=1}^nE[ \mathbb{1}_{Xm>max_{i<m}(X_{i})}]=\sum_{m=1}^n P(Xm>max_{i<m}X_{i})=\sum_{m=1}^n \frac{1}{m}$

On a alors pour $n=27$:
$E(N)\approx 3.89$

##### Question 3

* Calculer ${\rm E}[Y_n]$.

###### Réponse : 

$$E(Y_{n})=\frac{n-1}{2}$$


$P(U_1<U_2)+P(U_1>U_2)+P(U_1=U_2)=1$
or $U_i$ sont des variables aleatoires suivant la meme loi et totalement indépendantes donc $P(U_1<U_2)=P(U_2<U_1)$ et ainsi $P(U_1<U_2)=\frac{1}{2}$

$P(U_1<U_2<U_3)=P(U_1=x<U_2=y<U_3=z)=\int_{x=0}^1\int_{y=x}^1\int_{z=y}^1dzdydx=\int_{x=0}^1\int_{y=x}^1 1-y dydx =\int_{x=0}^1 \frac{1}{2}-x+\frac{x^2}{2}dx=0.5-0.5+[\frac{x^3}{6}]_0^1=\frac{1}{6}$

$P(U_1<U_2<U_3)=\frac{1}{6}$



$E(Y_{n})=E[\sum_1^{n-1} X_{i}]=\sum_1^{n-1} E[X_{i}]=\sum_1^{n-1} P(X_{i+1}>X_{i})=\sum_1^{n-1}\frac{1}{2}=\frac{n-1}{2}$

car $P(U_{2}>U_{1})=P(U_{i+1}>U_{i})= E(X_{i})$ pour i dans $\llbracket 0,n\rrbracket$.


##### Question 4

* Calculer la valeur de la variance Var$[Y_3]$.

###### Réponse : 

$$Var[Y_{3}]=\frac{1}{3}$$

$Var[X_{1}]=E[(X-E[X])^{2}]=E[X^2]-E[X]^2=\frac{1}{2}-\frac{1}{4}=\frac{1}{4}$

Soit $Z=X_{1}X_{2}$, alors,$Z=1$ seulement si $U_{1}<U_{2}<U_{3}$, donc:

$Cov[X_{1},X_{2}]=E[Z]-E[X_{1}] E[X_{2}]= \frac{1}{6} -\frac{1}{2}\times\frac{1}{2}=-\frac{1}{12}$

On a finalement:
$Var[Y_{3}]=Var[X_{1}+X_{2}]=Var[X_{1}]+Var[X_{2}]+2Cov[X_{1},X_{2}]=2\times\frac{1}{4}-2\times\frac{1}{12}=\frac{2}{6}=\frac{1}{3}$

##### Question 5

* Calculer Var$[Y_n]$ pour tout $n \geq 2$.

###### Réponse : 

$$Var[Y_n]=\frac{n+1}{12}$$

$Var(Y_n)=\sum_{i=1}^{n-1}Var(X_i)+2\sum_{1\leq i<j\leq n-1}Cov(X_i,X_j)$

or $X_i= 1 \text{ si } U_i<U_{i+1}$ donc les X_i sont tous indépendants entre eux exceptés les consécutifs et la dernier covariance (entre $X_{n-1}$ et $X_n$ n'existe pas)

ainsi $Var[Yn]=\sum_{i=1}^{n−1}Var[Xi]+2\sum_{i=1}^{n−2}Cov[X_i,X_{i+1}]$  

$Var[Y_n]=\frac{n-1}{4}-2\times (n-2)\times \frac{1}{12}=\frac{n+1}{12}$

##### Question 6

* Combien de tirages suffisent pour qu'avec une probabilité supérieure à 0.99, $A_{n-1}$ soit proche de la valeur 1/2 à $10^{-2}$ près. 

###### Réponse : 

**n=83337**

On sait que $E(A_{n-1})=\frac{E[Y_n]}{n-1}=1/2$ (Calcul rapide avec l'esperance d'$Y_{n}$)
On utilise l'inégalité de Bienaymé-Tchebychev:

$P(|A_{n-1}-E(A_{n-1})|\geq 10^{-2}) \leq \frac{Var(A_{n-1})}{10^{-2^{2}}}$

Donc:  
$P(|A_{n-1}-E(A_{n-1})|\leq10^{-2}) \geq 1- \frac{Var(A_{n-1})}{10^{-4}}$

Et on cherche le $n$ tel que  $P(|A_{n-1}-E(A_{n-1})|\leq10^{-2})=0.99$

$0.99 \geq 1- \frac{Var(A_{n-1})}{10^{-4}}$

$Var(A_{n-1})\geq 10^{-6}$

Or:  
$Var(A_{n-1})=\frac{Var(Y_{n})}{(n-1)^{2}}=\frac{n+1}{12(n-1)^{2}}$

Finallement:  
$\frac{n+1}{12(n-1)^{2}}\geq10^{-6}$

Et , après résolution de l'équation, on obtient:
$n\geq 83336.333\text{ donc }n=83337$

##### Question 7

* Déterminer la valeur de $c$.

###### Réponse : 

**c=10** 

$\int_{\mathbb{R}²}f(x,y)dxdy=1$

$\Leftrightarrow \int_{[0,1]²}cxy^2dxdy=1$

$\Leftrightarrow \int_{y\in[0,1]}\int_{x\in[0,y]}x\times y^2dxdy=1/c$

$\Leftrightarrow \int_{y\in[0,1]}y^2\times\frac{y^2}{2}dxdy=1/c$

$\Leftrightarrow \int_{y\in[0,1]}\frac{y^4}{2}dy=1/c$

$\Leftrightarrow [\frac{y^5}{10}]_0^1=1/c$

$\Leftrightarrow c=10$

##### Question 8

* Déterminer la fonction de répartition de la variable $Y$. Donner sa valeur au point $t = 2/3$. 

###### Réponse : 

$$ F_Y(\frac{2}{3})\approx 0.13$$

Notons f la densité de probabilité de Y
D'après la formule de la densité marginale pour $Y\in\mathbb{R}$ on a:

$f(y)=\int_\mathbb{R}f(x;y)dx=\int_\mathbb{R}10xy^2\mathbb{1}_D(x,y)dx$  
où $\mathbb{1}_D(x,y)=\mathbb{1}_{]0,1[}(y)\mathbb{1}_{]0,y[}(x)$  
donc $f(y)=10y^2\mathbb{1}_{]0,1[}(y)\int_0^yxdx=5y^4\mathbb{1}_{]0,1[}(y)$  
on a pour $y\in]0,1[ f(y)=F'_Y(y)$ avec $F_Y$ la fonction de répartition de Y.

Ainsi $F_Y(t)= \text{0 si t<0 } ; t^5\text{ si t}\in[0;1] ; 1\text{ si t>1}$

Ainsi:
$F_{Y}(\frac{2}{3})= (\frac{2}{3})^{5}\approx 0.13$

##### Question 9

* Ecrire un algorithme de simulation d'un couple de densité $f(x,y)$.  

###### Réponse : 

* Algorithme :
  * on simule X et Y avec leur densité respective (Uniforme pour Y et  conditionnée par Y pour X)
  * si X$\leq$Y alors:
  * f= $10\times X \times Y^2$
  * fin si
  * renvoie f
* fin Algorithme

##### Question 10


* On pose $Z =  X Y$. Déterminer la densité de la loi de la variable $Z$.
   
###### Réponse : 


** ** 


