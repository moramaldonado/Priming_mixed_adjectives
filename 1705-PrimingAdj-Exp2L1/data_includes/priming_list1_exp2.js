var shuffleSequence = seq("00", "instr", "practice", rshuffle(startsWith("E2")),  "form",  "sr","code");

function generateRandomNumber(){
    var num = Math.floor(Math.random()*10+36);
    var myArray = ['A', 'J', 'H','R'];
    var rand = myArray[Math.floor(Math.random() * myArray.length)];
    var myArray2 = ['M', 'R', 'S', 'T'];
    var rand2 = myArray2[Math.floor(Math.random() * myArray2.length)];
    var myArray3 = ['O', 'E', 'T'];
    var rand3 = myArray3[Math.floor(Math.random() * myArray3.length)];
    var num2 = Math.floor(Math.random()*10+50);

    var n = String(rand)+String(num)+String(rand3)+String(num2)+String(rand2);

    return n;
}


var defaults = [
    "NewMessage", {hideProgressBar: true,},

    "PictureAccept", {presentAsScale: true, hideProgressBar: true, hasCorrect: true, },

    "Feedback", {hideProgressBar: true, transfer: 8000, normalMessage: "Good answer!", errorMessage: "Wrong answer!"},

    "NewForm", {
        hideProgressBar: true,
        continueOnReturn: true,
        saveReactionTime: true
    },
];

var items = [
    
    ['00', "NewForm", {html: {include: 'agreement_EN.html'}}],
    ['instr',"NewMessage", {html: {include: 'instructions.html'}}],

    ['practice','PictureAccept',{s:'Only the bag is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bag_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/every_1.png']]},
    ],
    ['practice','PictureAccept',{s:'The watch is expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watch_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-watches.png']]},
    ],

    ['E2_C_C_matching_matching_loud/quiet_0_loud/quiet_0_R-L-R','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]},'PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]},'PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-instruments.png']]}],
    ['E2_C_C_mismatching_matching_expensive/cheap_0_heavy/light_0_R-L-R','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]},'PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]},'PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png']]}],
    ['E2_C_C_matching_mismatching_expensive/cheap_0_expensive/cheap_0_L-R-R','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]},'PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]},'PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-cars.png']]}],
    ['E2_C_C_mismatching_mismatching_loud/quiet_0_expensive/cheap_0_R-L-L','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png']]},'PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]},'PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-watches.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],

    ['E2_C_D_matching_matching_heavy/light_0_heavy/light_1_R-L-R','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_1.png']]},'PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png']]},'PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],
    ['E2_C_D_mismatching_matching_loud/quiet_0_expensive/cheap_1_L-R-L','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]},'PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png']]},'PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-watches.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['E2_C_D_matching_mismatching_loud/quiet_0_loud/quiet_1_L-R-R','PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]},'PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]},'PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-birds.png']]}],
    ['E2_C_D_mismatching_mismatching_loud/quiet_0_heavy/light_1_R-L-L','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png']]},'PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]},'PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],

    ['E2_D_C_matching_matching_expensive/cheap_1_expensive/cheap_0_L-R-L','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]},'PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]},'PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-watches.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],
    ['E2_D_C_mismatching_matching_heavy/light_1_expensive/cheap_0_R-L-R','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]},'PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]},'PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-cars.png']]}],
    ['E2_D_C_matching_mismatching_loud/quiet_1_loud/quiet_0_R-L-L','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_0.png']]},'PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]},'PictureAccept',{s:'The birds are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-birds.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]}],
    ['E2_D_C_mismatching_mismatching_expensive/cheap_1_heavy/light_0_L-R-R','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]},'PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]},'PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],

    ['E2_D_D_matching_matching_expensive/cheap_1_expensive/cheap_1_L-R-L','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]},'PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]},'PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-cars.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]}],
    ['E2_D_D_mismatching_matching_expensive/cheap_1_loud/quiet_1_R-L-R','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]},'PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]},'PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-birds.png']]}],
    ['E2_D_D_matching_mismatching_heavy/light_1_heavy/light_1_L-R-R','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png']]},'PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_0.png']]},'PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png']]}],
    ['E2_D_D_mismatching_mismatching_heavy/light_1_expensive/cheap_1_R-L-L','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]},'PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]},'PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-cars.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]}],

    ['E2_Control-Foil-Blur_loud/quiet_1_R-L','PictureAccept',{s:'Only the trumpet is quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/trumpet_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-trumpets.png']]}],
    ['E2_Control-Foil-Blur_heavy/light_1_L-R','PictureAccept',{s:'Only the bag is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bag_0.png']]}],
    ['E2_Control-Foil-Blur_expensive/cheap_0_R-L','PictureAccept',{s:'Only the book is expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/book_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],
    ['E2_Control-Foil-Blur_heavy/light_1_L-R','PictureAccept',{s:'Only the bag is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bag_0.png']]}],
    ['E2_Control-Foil-Blur_loud/quiet_0_R-L','PictureAccept',{s:'The drum is loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/drum_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-drums.png']]}],
    ['E2_Control-Foil-Blur_heavy/light_0_R-L','PictureAccept',{s:'The book is heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/book_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],
    ['E2_Control-Foil-Blur_loud/quiet_1_L-R','PictureAccept',{s:'The drum is quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-drums.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/drum_0.png']]}],
    ['E2_Control-Foil-Blur_heavy/light_1_L-R','PictureAccept',{s:'The book is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/book_0.png']]}],

    ['E2_Control-Both-C_expensive/cheap_0_R-L','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png']]}],
    ['E2_Control-Both-C_loud/quiet_0_L-R','PictureAccept',{s:'The instruments are loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['E2_Control-Both-C_expensive/cheap_0_R-L','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]}],
    ['E2_Control-Both-C_heavy/light_0_L-R','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['E2_Control-Both-C_heavy/light_0_L-R','PictureAccept',{s:'The books are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_01.png']]}],
    ['E2_Control-Both-C_heavy/light_0_R-L','PictureAccept',{s:'The bags are heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_0.png']]}],
    ['E2_Control-Both-C_expensive/cheap_0_R-L','PictureAccept',{s:'The watches are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_0.png']]}],
    ['E2_Control-Both-C_expensive/cheap_0_L-R','PictureAccept',{s:'The cars are expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png']]}],

    ['E2_Control-Both-D_loud/quiet_1_L-R','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]}],
    ['E2_Control-Both-D_loud/quiet_1_L-R','PictureAccept',{s:'The birds are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/birds_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/birds_01.png']]}],
    ['E2_Control-Both-D_heavy/light_1_R-L','PictureAccept',{s:'The books are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/books_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/books_1.png']]}],
    ['E2_Control-Both-D_expensive/cheap_1_R-L','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png']]}],
    ['E2_Control-Both-D_loud/quiet_1_L-R','PictureAccept',{s:'The instruments are quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/instruments_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/instruments_01.png']]}],
    ['E2_Control-Both-D_expensive/cheap_1_R-L','PictureAccept',{s:'The cars are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/cars_01.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/cars_1.png']]}],
    ['E2_Control-Both-D_heavy/light_1_L-R','PictureAccept',{s:'The bags are light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bags_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bags_01.png']]}],
    ['E2_Control-Both-D_expensive/cheap_1_L-R','PictureAccept',{s:'The watches are cheap.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watches_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/watches_01.png']]}],

    ['E2_Control-True-Blur_loud/quiet_1_L-R','PictureAccept',{s:'Only the trumpet is quiet.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-trumpets.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/trumpet_1.png']]}],
    ['E2_Control-True-Blur_expensive/cheap_0_R-L','PictureAccept',{s:'Only the book is expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/book_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],
    ['E2_Control-True-Blur_loud/quiet_0_R-L','PictureAccept',{s:'The bird is loud.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bird_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-birds.png']]}],
    ['E2_Control-True-Blur_heavy/light_0_R-L','PictureAccept',{s:'The bag is heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bag_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png']]}],
    ['E2_Control-True-Blur_heavy/light_1_R-L','PictureAccept',{s:'Only the watch is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/watch_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-watches.png']]}],
    ['E2_Control-True-Blur_heavy/light_0_L-R','PictureAccept',{s:'The bag is heavy.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/bag_0.png']]}],
    ['E2_Control-True-Blur_expensive/cheap_0_R-L','PictureAccept',{s:'The book is expensive.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/book_0.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-books.png']]}],
    ['E2_Control-True-Blur_heavy/light_1_R-L','PictureAccept',{s:'Only the bag is light.',as:[['D', 'http://mmaldonado.psycholinguae.fr/img/bag_1.png'], ['K', 'http://mmaldonado.psycholinguae.fr/img/hidden-bags.png']]}],



    ["form", "NewForm", {html:{include: 'questionary.html'}}],
    ["sr", "__SendResults__", { }],

    ["code", "Code", {html: "<h2>To validate your participation, please go back to Mechanical Turk and enter the code below. </h2><br>" + generateRandomNumber()}],

];