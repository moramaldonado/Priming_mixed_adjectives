#Validation script to check number of items in each condition. This is for three-level embedded things.
# DATA = big list of TRIALS
# x = fist variable
# y = second variable

def validation(DATA, x, y):
    lista = []
    for i in range(len(DATA)):
        if y != False:
            lista.append(DATA[i][x][y])
        elif y == False:
            lista.append(DATA[i][x])
    print [[t, lista.count(t)] for t in set(lista)]
