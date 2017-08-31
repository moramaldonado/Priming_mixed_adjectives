# CODE
# 0 = heavy-type = POS = C
# 1 = light-type = NEG = D

##Required packages

import pygame
from to_ibex import *
import random
import os

#PARAMETERS
image_path= 'http://mmaldonado.psycholinguae.fr/img/'
predicate_type = [0, 1] # 0=positive valence (heavy_type), 1= negative valence (light_type)

predicates = {'heavy/light': ['bags', 'books'],
              'expensive/cheap':['cars','watches'],
              'loud/quiet': ['birds','instruments']}

conditions_targets = {'C':['01','hidden','0'], 'D':['01','hidden','1']} # Condition for overt picture: {overt_image, blur,  valence}

conditions_prime_exp1 = {'C':['01','1','0'], 'D':['01','0','1'], 'Baseline':['X','X', 'X']} # Condition for overt picture: {overt_image, blur,  valence}
conditions_prime_exp2 = {'C':['01','1','0'], 'D':['01','0','1']} # Condition for overt picture: {overt_image, blur,  valence}


conditions_controls = {'Foil-Blur': ['X', 'hidden', 'X'], 'True-Blur': ['X', 'hidden', 'X'], 'Both-C': ['01', '0', '0'],
                       'Both-D': ['01', '1', '1']}


n_controls = 0

predicate_condition = ['matching', 'mismatching']
image_condition = ['matching', 'mismatching']
path = os.path.dirname(__file__)



baseline_type_1 = ['the','only','only','the','the','only','only','the']
baseline_type_2 = ['only','the','the','only','only','the','the','only',]
print baseline_type_1
print baseline_type_2

TRIALS = []


exp = raw_input('Experiment (1 or 2):')

if exp == "1":
    conditions_prime = conditions_prime_exp1
elif exp == "2":
    conditions_prime = conditions_prime_exp2

for list in range(1,3):
    name_ibex= 'priming_ibex'+str(list)+str(exp)+'.txt'
    name_validation = 'priming_validation' + str(list) + str(exp)+'.csv'
    ibex = open(name_ibex, 'w')
    validation = open(name_validation, 'w')
    if list==1:
        baseline_type = baseline_type_1
    else:
        baseline_type = baseline_type_2

    n_baseline = 0


    #EXPERIMENTAL ITEMS
    for p in conditions_prime:
        for t in conditions_targets: # 2 D, C
            for img in image_condition: # 2 mismatching, matching
                for pred in predicate_condition: #2 mismatching, matching

                    prime1 = {}
                    prime2 = {}
                    target = {}

                    target['condition'] = t
                    prime1['condition'] = p
                    prime2['condition'] = p

                    exemplars = []

                    if pred == 'matching':
                        random_predicate = random.choice(predicates.keys())
                        random_predicate = [random_predicate,random_predicate]
                        random.shuffle(predicates[random_predicate[0]])

                        exemplars.append(predicates[random_predicate[0]][0])

                        exemplars.append(predicates[random_predicate[0]][1])

                        exemplars.append(predicates[random_predicate[0]][0])

                        #print exemplars

                    else:
                        random_predicate = random.sample(predicates.keys(), 2)
                        random.shuffle(predicates[random_predicate[0]])
                        exemplars = predicates[random_predicate[0]] + random.sample(predicates[random_predicate[1]], 1)
                        #print exemplars


                    baseline_predicate = ['0', '1']
                    random.shuffle(baseline_predicate)
                    #random.shuffle(baseline_type)
                    if exp=='1':
                        conditions_prime['Baseline'][2] = baseline_predicate[0]

                    prime1['predicate'] = random_predicate[0]
                    prime1['valence'] = conditions_prime[p][2] # whether light type or heavy type

                    prime2['predicate'] = random_predicate[0]
                    prime2['valence'] = conditions_prime[p][2] # whether light type or heavy type

                    # BASELINES

                    if p == 'Baseline':
                        ###here



                        prime1['condition'] = prime1['condition'] +'-' + baseline_type[n_baseline]
                        prime2['condition'] = prime1['condition']


                        if prime1['predicate'] != 'loud/quiet':
                            base = random.sample(['watch', 'book', 'bag'], 2)
                            code='every_'
                        else:
                            base = random.sample(['bird', 'trumpet', 'drum'], 2)
                            code = 'every_noise_'

                        prime1['exemplar'] = base[0]
                        prime2['exemplar'] = base[1]

                        if baseline_type[n_baseline] == 'only':
                            conditions_prime['Baseline'][0] = baseline_predicate[0]
                            conditions_prime['Baseline'][1] = code+baseline_predicate[0]


                            prime1['sentence'] = 'Only the ' + prime1['exemplar'] + ' is ' + prime1['predicate'].split('/')[
                                int(prime1['valence'])] + '.'
                            prime2['sentence'] = 'Only the ' + prime2['exemplar'] + ' is ' + prime2['predicate'].split('/')[
                                int(prime2['valence'])] + '.'
                        else:
                            conditions_prime['Baseline'][0] = baseline_predicate[0]
                            conditions_prime['Baseline'][1] = code+baseline_predicate[1]


                            prime1['sentence'] = 'The ' + prime1['exemplar'] + ' is ' + prime1['predicate'].split('/')[
                                int(prime1['valence'])] + '.'
                            prime2['sentence'] = 'The ' + prime2['exemplar'] + ' is ' + prime2['predicate'].split('/')[
                                int(prime2['valence'])] + '.'

                        n_baseline = n_baseline + 1

                    elif p != 'Baseline':
                        prime1['exemplar'] = exemplars[0]  # random exemplar
                        prime2['exemplar'] = exemplars[1]  # random exemplar

                        prime1['sentence'] = 'The ' + prime1['exemplar'] + ' are ' + prime1['predicate'].split('/')[int(prime1['valence'])] + '.'
                        prime2['sentence'] = 'The ' + prime2['exemplar'] + ' are ' + prime2['predicate'].split('/')[int(prime2['valence'])] + '.'


                    target['predicate'] = random_predicate[1]
                    target['exemplar'] = exemplars[2]  # random exemplar
                    target['valence'] = conditions_targets[t][2] # whether light type or heavy type
                    target['sentence'] = 'The ' + target['exemplar'] + ' are ' + target['predicate'].split('/')[int(target['valence'])] + '.'

                    if img == 'matching':
                        order = random.choice([['L', 'R', 'L'], ['R', 'L', 'R']])
                        prime1['img_' + order[0]] = prime1['exemplar'] + '_' + conditions_prime[p][1] + '.png' #FOIL
                        prime1['img_' + order[1]] = prime1['exemplar'] + '_' + conditions_prime[p][0] + '.png' #TARGET
                        prime2['img_' + order[1]] = prime2['exemplar'] + '_' + conditions_prime[p][1] + '.png' #FOIL
                        prime2['img_' + order[0]] = prime2['exemplar'] + '_' + conditions_prime[p][0] + '.png' #TARGET

                        if p == 'Baseline': #foils in baselines are slightly different
                            prime1['img_' + order[0]] = conditions_prime[p][1] + '.png'  # FOIL
                            prime2['img_' + order[1]] = conditions_prime[p][1] + '.png'  # FOIL

                        target['img_' + order[2]] = conditions_targets[t][1]+'-'+target['exemplar']+ '.png' #BLUR
                        target['img_' + order[1]] = target['exemplar'] + '_' + conditions_targets[t][0] + '.png' #OVERT
                        target['responses'] = order

                    else:
                        order = random.choice([['L', 'R', 'R'], ['R', 'L', 'L']])

                        prime1['img_' + order[0]] = prime1['exemplar'] + '_' + conditions_prime[p][1] + '.png' #FOIL
                        prime1['img_' + order[1]] = prime1['exemplar'] + '_' + conditions_prime[p][0] + '.png' #TARGET

                        prime2['img_' + order[1]] = prime2['exemplar'] + '_' + conditions_prime[p][1] + '.png' #FOIL
                        prime2['img_' + order[0]] = prime2['exemplar'] + '_' + conditions_prime[p][0] + '.png' #TARGET

                        if p == 'Baseline': #foils in baselines are slightly different
                            prime1['img_' + order[0]] = conditions_prime[p][1] + '.png'  # FOIL
                            prime2['img_' + order[1]] = conditions_prime[p][1] + '.png'  # FOIL

                        target['img_' + order[2]] = conditions_targets[t][1]+'-'+target['exemplar']+ '.png' #BLUR
                        target['img_' + order[0]] = target['exemplar'] + '_' + conditions_targets[t][0] + '.png' #OVERT


                    ITEM = {}
                    ITEM['target'] = target
                    ITEM['prime1'] = prime1
                    ITEM['prime2'] = prime2
                    ITEM['responses'] = order
                    ITEM['condition'] = prime1['condition']+'_'+target['condition']
                    ITEM['predicate_condition']= pred
                    ITEM['img_condition'] = img
                    # ITEM['info'] = Experiment_ConditionPrime_ConditionTarget_PredicateCondition_ImgCondition_PredicatePrime_PredicateTarget_ValencePrime_ValenceTarget_ResponseOrder
                    ITEM['info'] = 'E'+exp+'_'+ITEM['condition'] + '_' + ITEM['predicate_condition'] + '_' + ITEM['img_condition'] + '_' + ITEM['prime1']['predicate'] + '_' + ITEM['prime1']['valence'] + '_' + ITEM['target']['predicate'] + '_' + ITEM['target']['valence'] + '_' + '-'.join(ITEM['responses'])
                    data_line = to_ibex_priming(ITEM, '\'PictureAccept\'', 'prime1','prime2','target', image_path)
                    print >> ibex, data_line
                    print >> validation, 'prime1', ',', ITEM['prime1']['condition'], ',', ITEM['prime1']['sentence'], ',',ITEM['prime1']['img_L'], ',',ITEM['prime1']['img_R'],',',ITEM['predicate_condition'],',', ITEM['img_condition']
                    print >> validation, 'prime2', ',',ITEM['prime2']['condition'], ',', ITEM['prime2']['sentence'], ',',ITEM['prime2']['img_L'], ',',ITEM['prime2']['img_R'],',',ITEM['predicate_condition'],',', ITEM['img_condition']
                    print >> validation, 'target', ',',ITEM['target']['condition'], ',', ITEM['target']['sentence'], ',',ITEM['target']['img_L'], ',',ITEM['target']['img_R'],',',ITEM['predicate_condition'],',', ITEM['img_condition']


                    TRIALS.append(ITEM)

    #CONTROLS




    for c in conditions_controls:
        for i in range(8):
            control={}
            baseline_predicate = ['0', '1']
            random.shuffle(baseline_predicate)
            conditions_controls['Foil-Blur'][2] = baseline_predicate[0]
            conditions_controls['True-Blur'][2] = baseline_predicate[0]

            conditions_controls['Foil-Blur'][0] = baseline_predicate[1] #Foil
            conditions_controls['True-Blur'][0] = baseline_predicate[0] #True

            control['predicate'] = random.choice(predicates.keys())
            control['valence'] = conditions_controls[c][2]  # whether light type or heavy type
            control['condition'] = c

            if c != 'Both-C' and c != 'Both-D':
                control['type'] = random.choice(['only','the'])
                if control['predicate'] != 'loud/quiet':
                    base = random.sample(['watch', 'book', 'bag'], 1)
                else:
                    base = random.sample(['bird', 'trumpet', 'drum'], 1)

                control['exemplar'] = base[0]

                if control['type'] == 'only':
                    control['sentence'] = 'Only the ' + control['exemplar'] + ' is ' + control['predicate'].split('/')[int(control['valence'])] + '.'
                else:
                    control['sentence'] = 'The ' + control['exemplar'] + ' is ' + control['predicate'].split('/')[int(control['valence'])] + '.'

                order = random.choice([['L', 'R'], ['R', 'L']])
                control['img_' + order[0]] = conditions_controls[c][1] + '-' + control['exemplar']+'s' + '.png'  # BLUR/BOTH
                control['img_' + order[1]] = control['exemplar'] + '_' + conditions_controls[c][0] + '.png'  # OVERT
                control['responses'] = order

            elif c == 'Both-C' or c == 'Both-D':
                control['exemplar'] = random.sample(predicates[control['predicate']], 1)[0]
                control['sentence'] = 'The ' + str(control['exemplar']) + ' are ' + control['predicate'].split('/')[int(control['valence'])] + '.'
                order = random.choice([['L', 'R'], ['R', 'L']])
                control['img_' + order[0]] = str(control['exemplar']) + '_' + conditions_controls[c][1] + '.png'  # BLUR/BOTH
                control['img_' + order[1]] = str(control['exemplar']) + '_' + conditions_controls[c][0] + '.png'  # OVERT
                control['responses'] = order


            control['info'] = 'E'+exp+'_Control-'+control['condition'] + '_' + control['predicate'] + '_' + control['valence'] + '_' + '-'.join(control['responses'])
            data_line = to_ibex_single(control, '\'PictureAccept\'', image_path)
            print >> ibex, data_line
            print >> validation, 'control', ',', control['condition'], ',', control['sentence'], ',', \
           control['img_L'], ',', control['img_R']



ibex.close()
validation.close()



