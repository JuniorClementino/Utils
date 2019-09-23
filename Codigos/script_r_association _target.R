setwd("teste")
if(!"arules" %in% installed.packages()[,1]){
  install.packages("arules", lib = "./src_lib", dependencies = TRUE)
}
library(arules, lib.loc = c(.libPaths(), "./src_lib"))

if(!"arulesViz" %in% installed.packages()[,1]){
  install.packages("arulesViz", lib = "./src_lib", dependencies = TRUE)
}
library(arulesViz, lib.loc = c(.libPaths(), "./src_lib"))

if(!"discretization" %in% installed.packages()[,1]){
  install.packages("arulesViz", lib = "./src_lib", dependencies = TRUE)
}
library(discretization, lib.loc = c(.libPaths(), "./src_lib"))



if(!"arulesCBA" %in% installed.packages()[,1]){
  install.packages("arulesCBA", lib = "./src_lib", dependencies = TRUE)
}
library(arulesCBA, lib.loc = c(.libPaths(), "./src_lib"))




base = read.transactions('/home/junior/venvs/OMOP_ETL/Utils/Codigos/com_target.csv',header = F, sep=",", rm.duplicates = T)
base
summary(base)


#Observando algumas linhas
inspect(base[1:4])  #linhas da matriz são cestas de compras

#colunas da matriz são itens
itemFrequency(base[,1:10]) #vendo  os numero
itemFrequencyPlot(base[,1:10]) #Grafico de barras


#É possivel colocar no gráfico somente itens com um certo suporte
itemFrequencyPlot(base, support =0.2) # ou - 0.1


## É possivel fazer seus próprios gráficos
itens <- itemFrequency(base)
itens <- itens[order(itens, decreasing = T)]
dotchart(itens)

# O mesmo gráfico com menos itens
dotchart(itens[1:10], cex = 0.8)
itemFrequencyPlot(base, topN=10)

##Encontrando as regras de associacao com o algortimo Aprori
regras <- apriori(base, parameter  =list(support=0.2, confidence=0.5, minlen=2))

#inspecionando as regras 
summary(regras)

#Vendo as regras 
inspect(regras[1:3])
inspect(regras)
inspect(sort (regras, by = 'confidence'))

#Visualizando as regras como um grafo
#plot(regras, method = 'scatterplot', interactive=T, shading=NA)
#plot(regras, method = 'two-key plot', interactive=T, shading=NA)


#Fazendo o gráfico do lift pelo suporte
#plot(regras, measure-C("support","lift"), shading="confidence")

#Obtendo um conjunto menor de regras
#subregras <- regras[quality(regras)$confidence >0.8]

#--------------------------------------------------------------------------------------------------------------#
rules <- apriori(base, control = list(verbose=F),
                 parameter = list(minlen=2, supp=0.02, conf=0.8),
                 appearance = list(rhs=c("2", "1","3","4","5","6","7", "8"),
                                   default="lhs"))
quality(rules) <- round(quality(rules), digits=3)
rules.sorted <- sort(rules, by="lift")
inspect(rules(rules))
inspect(rules[1:3])
inspect(rules)
inspect(sort (rules, by = 'confidence'))


rules_2 <- apriori(
  data = base, parameter = list(
    supp = 0.001,conf = 0.08),
  appearance = list(
    default = "lhs",
    rhs = '7' ), control=list(verbose=F)
)
rules_2


inspect(rules(rules_2))
inspect(rules_2[1:3])
inspect(rules_2)
inspect(sort (rules_2, by = 'confidence'))

r <- apriori(base, parameter = list(support = 0.1, confidence = 0.1))
inspect( subset( r, subset = rhs %pin% "target=" ) )

inspect(rules(r))
inspect(r[1:3])
inspect(r)
inspect(sort (r, by = 'confidence'))

data = base
CBA(formula, data, support = 0.2, confidence = 0.8,
    verbose=FALSE, parameter = NULL, control = NULL,
    sort.parameter = NULL, lhs.support = FALSE,
    disc.method = "mdlp")
# learn a classifier using automatic default discretization
classifier <- CBA(target ~ ., data = base, supp = 0.001, conf = 0.5)
classifier

# make predictions for the first few instances of iris
predict(classifier, head(base))

# inspect the rule base
inspect(rules(classifier))

# learn classifier from transactions
trans <- as(discretizeDF.supervised(target ~ ., base), "transactions")
classifier <- CBA(target ~ ., data = trans, supp = 0.05, conf = 0.9)
classifier
predict(classifier, head(trans))



#Fazendo os gráficos de matrizes
plot(subregras, method = 'matrix', interactive= TRUE, shading=NA)
plot(regras, method = 'matrix3D', interactive= TRUE, shading=NA)

#Agora mudando a ordem
plot(regras, method="grouped", control = list(k=50),cex=0.8)


#Plotando regras como grafos
subregras2 <- head(sort(regras, by ="lift"),10)
pdf(file - "grafos.pdf")
plot(subregras2, method="graph", control=list(tyoe="itemsets"))

