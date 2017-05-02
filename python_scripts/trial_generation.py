import pygame
from to_ibex import *
import validation
import random
import os

TRIALS_P1 = []
TRIALS_P2 = []
image_path= 'http://mmaldonado.psycholinguae.fr/img/'

lists = ['BP','FOIL', 'BLUR']

conditions_BP = {'X': ['01','01'] ,'Both':['0','1'],'Foil':['1','0']}

conditions_FOIL = {'X-Foil':[['01','1'],['01','0']],
                   'Both-Foil':[['0','1'],['1','0']],
                   'X-Both':[['01','0'],['01','0']]}

predicate_type = [0, 1]
predicates = {'heavy/light': ['bags', 'books'],
              'expensive/cheap':['cars','watches'],
              'loud/quiet':['birds','instruments']}

path = os.path.dirname(__file__)
toibex1a = open('stimuli_pilot1a_ibex.txt', 'w')
toibex1b = open('stimuli_pilot1b_ibex.txt', 'w')
toibex2 = open('stimuli_pilot2_ibex.txt', 'w')

for l in lists:
    for t in predicate_type:
        for p in predicates:
            if l == 'BP': #BETTER PICTURE kind of trials (Pilot 1)
                for c in conditions_BP:
                    for i in range(2):

                        trial = {}
                        trial['list'] = l
                         #Type of predicate depending on entailment patterns
                        trial['predicate_type'] = t

                        #Conditions
                        trial['condition'] = c

                        if trial['condition']=='X' and trial['predicate_type']==1:
                            trial['condition'] = 'D'
                        elif trial['condition']=='X' and trial['predicate_type']==0:
                            trial['condition'] = 'C'

                        trial['predicate'] = p

                        trial['exemplar'] = predicates[p][i]

                        #picture names: exemplar_{0/1/01}.png ; anotherpicture.png

                        pictures = {'AP': 'anotherpicture.png',
                                    trial['condition']: trial['exemplar']+'_'+ conditions_BP[c][t]+'.png'}

                        key = [trial['condition'], 'AP']
                        if i == 0:
                            trial['pictureA'] = pictures[key[0]]
                            trial['pictureB'] = pictures[key[1]]
                            trial['responses'] = key[0] + '/' + key[1]
                        else:
                            trial['pictureA'] = pictures[key[1]]
                            trial['pictureB'] = pictures[key[0]]
                            trial['responses'] = key[1] + '/' + key[0]


                        trial['sentence'] = 'The '+trial['exemplar']+' are ' + p.split('/')[t] + '.'

                        trial['index'] = 'a'+'_'+trial['condition']+'_'+trial['predicate']+'_'+str(trial['predicate_type'])+'_'+trial['exemplar']+'_'+trial['responses']

                        #print conditions_BP[c][t]

                        TRIALS_P1.append(trial)
                        data_line = to_ibex(trial, '\'PictureAccept\'', image_path)
                        print >> toibex1a, data_line



            elif l == 'BLUR': #BLUR PICTURE kind of trials (Pilot 1b)
                for c in conditions_BP:
                    for i in range(2):

                        trial = {}
                        trial['list'] = l
                         #Type of predicate depending on entailment patterns
                        trial['predicate_type'] = t

                        #Conditions
                        trial['condition'] = c

                        if trial['condition']=='X' and trial['predicate_type']==1:
                            trial['condition'] = 'D'
                        elif trial['condition']=='X' and trial['predicate_type']==0:
                            trial['condition'] = 'C'

                        trial['predicate'] = p

                        trial['exemplar'] = predicates[p][i]

                        #picture names: exemplar_{0/1/01}.png ; anotherpicture.png

                        pictures = {'AP': 'hidden-'+trial['exemplar']+'.png',
                                    trial['condition']: trial['exemplar']+'_'+ conditions_BP[c][t]+'.png'}

                        key = [trial['condition'], 'AP']
                        if i == 0:
                            trial['pictureA'] = pictures[key[0]]
                            trial['pictureB'] = pictures[key[1]]
                            trial['responses'] = key[0] + '/' + key[1]
                        else:
                            trial['pictureA'] = pictures[key[1]]
                            trial['pictureB'] = pictures[key[0]]
                            trial['responses'] = key[1] + '/' + key[0]


                        trial['sentence'] = 'The '+trial['exemplar']+' are ' + p.split('/')[t] + '.'

                        trial['index'] = 'b'+'_'+trial['condition']+'_'+trial['predicate']+'_'+str(trial['predicate_type'])+'_'+trial['exemplar']+'_'+trial['responses']

                        #print conditions_BP[c][t]

                        TRIALS_P1.append(trial)
                        data_line = to_ibex(trial, '\'PictureAccept\'', image_path)
                        print >> toibex1b, data_line








            elif l == 'FOIL':  # FOIL picture kind of trials (Pilot 2)
                for c in conditions_FOIL:
                    for i in range(2):
                        trial = {}
                        trial['list'] = l
                        # Type of predicate depending on entailment patterns
                        trial['predicate_type'] = t

                        # Conditions
                        trial['condition'] = c

                        if (trial['condition'] == 'X-Foil' or trial['condition'] == 'X-Both') and trial['predicate_type'] == 1:
                            trial['condition'] = trial['condition'] .replace('X','D')
                        elif (trial['condition'] == 'X-Foil' or trial['condition'] == 'X-Both') and trial['predicate_type'] == 0:
                            trial['condition'] = trial['condition'] .replace('X','C')

                        trial['predicate'] = p

                        # trial
                        trial['exemplar'] = predicates[p][i]
                        pictures = {trial['condition'].split('-')[0]: trial['exemplar']+'_'+ conditions_FOIL[c][t][0]+'.png',
                                    trial['condition'].split('-')[1]: trial['exemplar']+'_'+conditions_FOIL[c][t][1]+'.png'}

                        key = [trial['condition'].split('-')[0], trial['condition'].split('-')[1]]

                        if i == 0:
                            trial['pictureA'] = pictures[key[0]]
                            trial['pictureB'] = pictures[key[1]]
                            trial['responses'] = key[0] + '/' + key[1]
                        else:
                            trial['pictureA'] = pictures[key[1]]
                            trial['pictureB'] = pictures[key[0]]
                            trial['responses'] = key[1] + '/' + key[0]


                        trial['sentence'] = 'The ' + trial['exemplar'] + ' are ' + p.split('/')[t] + '.'
                        trial['index'] = '2'+'_'+trial['condition']+'_'+trial['predicate']+'_'+str(trial['predicate_type'])+'_'+trial['exemplar']+'_'+trial['responses']


                        TRIALS_P2.append(trial)
                        data_line = to_ibex(trial, '\'PictureAccept\'', image_path)
                        print >> toibex2, data_line

toibex1a.close()
toibex1b.close()

toibex2.close()






