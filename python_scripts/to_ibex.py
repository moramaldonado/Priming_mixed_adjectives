


def to_ibex_priming(TRIAL_INFO, CONTROLLER_1, item1, item2, item3, image_path):


    # data_line= [item_info, CONTROLLER, {s: prime1, as: [['D', prime1_picture_left],['K', prime1_picture_left]]},
    # CONTROLLER, {s: prime2, as: [['D', prime2_picture_left],['K', prime2_picture_left]]},
    # CONTROLLER, {s: target, as: [['D', target_picture_left],['K', target_picture_left]]}]

    coma = ','
    guion = '_'
    divisor1 = '\''
    divisor2 = '\"'

    item_info = divisor1+TRIAL_INFO['info']+divisor1
    sentence_item1 = '{s:\''+TRIAL_INFO[item1]['sentence']+'\''
    sentence_item2 = '{s:\'' + TRIAL_INFO[item2]['sentence'] + '\''
    sentence_item3 = '{s:\'' + TRIAL_INFO[item3]['sentence'] + '\''

    images_item1 = [['D', image_path+ TRIAL_INFO[item1]['img_L']],['K', image_path+TRIAL_INFO[item1]['img_R']]]
    images_item2 = [['D', image_path+ TRIAL_INFO[item2]['img_L']],['K', image_path+TRIAL_INFO[item2]['img_R']]]
    images_item3 = [['D', image_path+ TRIAL_INFO[item3]['img_L']],['K', image_path+TRIAL_INFO[item3]['img_R']]]

    data_line = '['+item_info+coma+CONTROLLER_1+coma+sentence_item1+',as:'+ str(images_item1)+'}'+coma+\
                CONTROLLER_1+coma+sentence_item2+',as:'+ str(images_item2)+'}' + coma+\
                CONTROLLER_1+coma+sentence_item3+',as:'+ str(images_item3)+'}],'

    return data_line



def to_ibex_single(TRIAL_INFO, CONTROLLER_1, image_path):

    # data_line= [item_info, CONTROLLER, {s: prime1, as: [['D', prime1_picture_left],['K', prime1_picture_left]]},
    # CONTROLLER, {s: prime2, as: [['D', prime2_picture_left],['K', prime2_picture_left]]},
    # CONTROLLER, {s: target, as: [['D', target_picture_left],['K', target_picture_left]]}]

    coma = ','
    guion = '_'
    divisor1 = '\''
    divisor2 = '\"'

    item_info = divisor1+TRIAL_INFO['info']+divisor1
    sentence_item1 = '{s:\''+TRIAL_INFO['sentence']+'\''
    images_item1 = [['D', image_path+ TRIAL_INFO['img_L']],['K', image_path+TRIAL_INFO['img_R']]]

    data_line = '['+item_info+coma+CONTROLLER_1+coma+sentence_item1+',as:'+ str(images_item1)+'}],'

    return data_line



def controls_to_ibex(TRIAL_INFO, CONTROLLER_1, image_path):
    coma = ','
    guion = '_'
    divisor1 = '\''
    divisor2 = '\"'
    item_info = divisor1+'UControl_'+TRIAL_INFO['position_target']+divisor1
    sentence_control = '{s:\''+TRIAL_INFO['sentence']+'\''

    if TRIAL_INFO['position_target'] == 'left':
        left = TRIAL_INFO['target_img_name']
        right = TRIAL_INFO['foil_img_name']
    else:
        right = TRIAL_INFO['target_img_name']
        left = TRIAL_INFO['foil_img_name']

    image_control = [['D', image_path+left],['K', image_path+right]]

    data_line1 = '['+item_info+coma+CONTROLLER_1+coma+sentence_control+',as:'+ str(image_control)+'}]'+coma

    return data_line1
