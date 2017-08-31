var shuffleSequence = seq("00", "instr", "practice", rshuffle(startsWith("a")), "instr2", rshuffle(startsWith("2")), "form",  "sr","code");

function generateRandomNumber(){
    var num = Math.floor(Math.random()*10+100);
    var myArray = ['M', 'K','L'];
    var rand = myArray[Math.floor(Math.random() * myArray.length)];
    var myArray2 = ['U', 'R', 'A', 'T'];
    var rand2 = myArray2[Math.floor(Math.random() * myArray2.length)];
    var myArray3 = ['Q', 'T', 'E'];
    var rand3 = myArray3[Math.floor(Math.random() * myArray3.length)];
    var num2 = Math.floor(Math.random()*10+75);

    var n = String(rand)+String(num)+String(rand3)+String(num2)+String(rand2);

    return n;
}


var defaults = [
    
    "NewMessage", {
        hideProgressBar: true,
},

"PictureAccept", {
    presentAsScale: true,
    hideProgressBar: true,

},

"NewForm", {
        hideProgressBar: true,
        continueOnReturn: true,
        saveReactionTime: true
    },
];

var items = [
    
    ['00', "NewForm", {html: {include: 'agreement_EN.html'}}],
    ['instr',"NewMessage", {html: {include: 'instructions.html'}}],
    ['practice','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],



    ['a_C_loud/quiet_0_birds_C/AP','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],

    ['a_C_loud/quiet_0_instruments_AP/C','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['a_Foil_loud/quiet_0_birds_Foil/AP','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_loud/quiet_0_instruments_AP/Foil','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]}],
    ['a_Both_loud/quiet_0_birds_Both/AP','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_loud/quiet_0_instruments_AP/Both','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png']]}],
    ['a_C_expensive/cheap_0_cars_C/AP','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_C_expensive/cheap_0_watches_AP/C','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['a_Foil_expensive/cheap_0_cars_Foil/AP','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_expensive/cheap_0_watches_AP/Foil','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]}],
    ['a_Both_expensive/cheap_0_cars_Both/AP','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_expensive/cheap_0_watches_AP/Both','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]}],
    ['a_C_heavy/light_0_bags_C/AP','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_C_heavy/light_0_books_AP/C','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['a_Foil_heavy/light_0_bags_Foil/AP','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_heavy/light_0_books_AP/Foil','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_1.png']]}],
    ['a_Both_heavy/light_0_bags_Both/AP','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_heavy/light_0_books_AP/Both','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_0.png']]}],
    ['a_D_loud/quiet_1_birds_D/AP','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_D_loud/quiet_1_instruments_AP/D','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['a_Foil_loud/quiet_1_birds_Foil/AP','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_loud/quiet_1_instruments_AP/Foil','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png']]}],
    ['a_Both_loud/quiet_1_birds_Both/AP','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_loud/quiet_1_instruments_AP/Both','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]}],
    ['a_D_expensive/cheap_1_cars_D/AP','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_D_expensive/cheap_1_watches_AP/D','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['a_Foil_expensive/cheap_1_cars_Foil/AP','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_expensive/cheap_1_watches_AP/Foil','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]}],
    ['a_Both_expensive/cheap_1_cars_Both/AP','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_expensive/cheap_1_watches_AP/Both','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]}],
    ['a_D_heavy/light_1_bags_D/AP','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_D_heavy/light_1_books_AP/D','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['a_Foil_heavy/light_1_bags_Foil/AP','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Foil_heavy/light_1_books_AP/Foil','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_0.png']]}],
    ['a_Both_heavy/light_1_bags_Both/AP','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png']]}],
    ['a_Both_heavy/light_1_books_AP/Both','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/anotherpicture.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_1.png']]}],


    ['instr2',"NewMessage", {html: {include: 'instructions_part2.html'}}],

    ['2_Both-Foil_loud/quiet_0_birds_Both/Foil','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png']]}],
    ['2_Both-Foil_loud/quiet_0_instruments_Foil/Both','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png']]}],
    ['2_C-Both_loud/quiet_0_birds_C/Both','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png']]}],
    ['2_C-Both_loud/quiet_0_instruments_Both/C','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['2_C-Foil_loud/quiet_0_birds_C/Foil','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png']]}],
    ['2_C-Foil_loud/quiet_0_instruments_Foil/C','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['2_Both-Foil_expensive/cheap_0_cars_Both/Foil','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png']]}],
    ['2_Both-Foil_expensive/cheap_0_watches_Foil/Both','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]}],
    ['2_C-Both_expensive/cheap_0_cars_C/Both','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]}],
    ['2_C-Both_expensive/cheap_0_watches_Both/C','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['2_C-Foil_expensive/cheap_0_cars_C/Foil','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png']]}],
    ['2_C-Foil_expensive/cheap_0_watches_Foil/C','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['2_Both-Foil_heavy/light_0_bags_Both/Foil','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png']]}],
    ['2_Both-Foil_heavy/light_0_books_Foil/Both','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_0.png']]}],
    ['2_C-Both_heavy/light_0_bags_C/Both','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]}],
    ['2_C-Both_heavy/light_0_books_Both/C','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['2_C-Foil_heavy/light_0_bags_C/Foil','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png']]}],
    ['2_C-Foil_heavy/light_0_books_Foil/C','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['2_Both-Foil_loud/quiet_1_birds_Both/Foil','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png']]}],
    ['2_Both-Foil_loud/quiet_1_instruments_Foil/Both','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]}],
    ['2_D-Both_loud/quiet_1_birds_D/Both','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png']]}],
    ['2_D-Both_loud/quiet_1_instruments_Both/D','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['2_D-Foil_loud/quiet_1_birds_D/Foil','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png']]}],
    ['2_D-Foil_loud/quiet_1_instruments_Foil/D','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['2_Both-Foil_expensive/cheap_1_cars_Both/Foil','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]}],
    ['2_Both-Foil_expensive/cheap_1_watches_Foil/Both','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]}],
    ['2_D-Both_expensive/cheap_1_cars_D/Both','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]}],
    ['2_D-Both_expensive/cheap_1_watches_Both/D','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['2_D-Foil_expensive/cheap_1_cars_D/Foil','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]}],
    ['2_D-Foil_expensive/cheap_1_watches_Foil/D','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['2_Both-Foil_heavy/light_1_bags_Both/Foil','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]}],
    ['2_Both-Foil_heavy/light_1_books_Foil/Both','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_1.png']]}],
    ['2_D-Both_heavy/light_1_bags_D/Both','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]}],
    ['2_D-Both_heavy/light_1_books_Both/D','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['2_D-Foil_heavy/light_1_bags_D/Foil','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]}],
    ['2_D-Foil_heavy/light_1_books_Foil/D','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],




    ["form", "NewForm", {html:{include: 'questionary.html'}}],
    ["sr", "__SendResults__", { }],

    ["code", "Code", {html: "<h2>To validate your participation, please go back to Mechanical Turk and enter the code below. </h2><br>" + generateRandomNumber()}],

];