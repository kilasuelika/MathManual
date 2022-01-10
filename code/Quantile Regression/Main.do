cd "F:\KnowledgeCenter\Connect\PT\数学与应用数学手册\code\Quantile Regression"
import delimited "I:\Research\Lab-Article1\Article1\Data\GetStockData\close.csv", clear

ren sh600850 y
ren sh600623 x

qreg y x, q(0.1)
predict yp1

qreg y x , q(0.9)
predict yp9

grstyle init
grstyle set imesh, horizontal compact minor
grstyle set legend 4, nobox

twoway (scatter y x) || (line yp1 x), name(p1, replace) title("p＝0.1")
twoway (scatter y x) || (line yp9 x), name(p9, replace) title("p=0.9")
gr combine p1 p9, row(1) xsize(10cm) ysize(4cm)
gr export "../../figure/Qreg.png", as(png) height(2000) width(5000) replace
