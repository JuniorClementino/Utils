## Caregando os pacotes necessários
library(arules)
library(arulesViz)

#Carregando o conjunto de dados
#data("Name_file")

#Inspecionando 
name_file <- read.transactions(file -'name_file.txt', sep - ',', rm.duplicates -r)

#Sumário 
summary(name_file)

#Observando algumas linhas
inspect(name_file[1:4])  #linhas da matriz são cestas de compras

#colunas da matriz são itens
itemFrequency(name_file[,1:10]) #vendo  os numero
itemFrequencyPlot(name_file[,1:10]) #Grafico de barras

#É possivel colocar no gráfico somente itens com um certo suporte
itemFrequencyPlot(name_file, support =0.1) # ou - 0.1

## É possivel fazer seus próprios gráficos
itens <- itemFrequency(name_file)
itens <- itens[order(itens, decreasing = T)]
dotchart(itens)

# O mesmo gráfico com menos itens
dotchart(itens[1:10], cex = 0.8)
itemFrequencyPlot(name_file, topN=10)

##Encontrando as regras de associacao com o algortimo Aprori
regras <- apriori(name_file, parameter  =list(support=0.001, confidence=0.5, minlen=2))

#inspecionando as regras 
summary(regras)

#Vendo as regras 
inspect(regras[1:3])
inspect(regras)
inspectsort((regras by = 'confidence'))

#Visualizando as regras como um grafo
plot(regras, method = 'scatterplot', interactive=True, shading=NA)
plot(regras, method = 'two-key plot', interactive=True, shading=NA)

#Fazendo o gráfico do lift pelo suporte
plot(regras, measure-C("support","lift"), shading="confidence")

#Obtendo um conjunto menor de regras
subregras <- regras[quality(regras)$confidence >0.8]

#Fazendo os gráficos de matrizes
plot(subregras, method = 'matrix', interactive= TRUE, shading=NA)
plot(regras, method = 'matrix3D', interactive= TRUE, shading=NA)

#Agora mudando a ordem
plot(regras, method="grouped", control = list(k=50),cex=0.8)


#Plotando regras como grafos
subregras2 <- head(sort(regras, by "lift"),10)
pdf(file - "grafos.pdf")
plot(subregras2, method="graph", control=list(tyoe="itemsets"))