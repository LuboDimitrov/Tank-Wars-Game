;LYUBOMIR LYUBOMIROV DIMITROV
;JOAN PASCUAL ALCARAZ

;funció que empleam per a que les instruccions
;s'entrin a la primera línia
(defun repetir (x)
    (eval x)
    (repetir(read))
)

;funció per a convertir graus a radiants
(defun DegtoRad (x)
   (/(* x 3.14159265358979)180)
)

;funció per emplenar un rectangle
(defun emplena(x y width height r g b)
(color r g b) ;definim el color passat per paràmetre
    (cond ((= height 0) nil)
        ;situam el cursor a la posicio x,y per emplenar
        (t(move x y)
          (drawrel width 0)
          (emplena x (+ y 1) width (- height 1) r g b)
        )
    )
)

;funció on es declaren els atributs de l'escenari
(defun carregarEscenari()
    ;guardam el color de fons
    (putprop 'colorfons 106 'r)
    (putprop 'colorfons 206 'g)
    (putprop 'colorfons 234 'b)

    ;calculam i guardam les coordenades necessàries
    (putprop 'escenari 0 'x1)
    (putprop 'escenari (+ 100 (random 301)) 'x2)
    (putprop 'escenari (+ 20 (random 131)) 'x3)
    (putprop 'escenari 640 'x4)
    (putprop 'escenari (random 300) 'y2)
    (putprop 'escenari (+(get 'escenari 'y2)
        (random (- 300 (get 'escenari 'y2)))) 'y1)
    (putprop 'escenari (random (get 'escenari 'y1)) 'y3)

    ;guardam el vent (aleatori)
    (putprop 'escenari  (+ (-(random 6)) (random 6)) 'vent)

)

;funció on es declaren els atributs dels canons
(defun carregarCanons()
    ;CANÓ 1
    ;calculam i guardam la seva posició
    (putprop 'cano (get 'escenari 'y2) 'cy)
    (putprop 'cano (+ 20 (random (-(get 'escenari 'x2)39))) 'cx)
    ;guardam l'angle del canó (inicialment 60 graus)
    (putprop 'cano (DegtoRad 60) 'angle)
    ;guardam la posició d'inici de la punta del canó
    (putprop 'cano (+(get 'cano 'cx)10) 'px)
    (putprop 'cano (+(get 'cano 'cy)10) 'py)

    ;CANÓ 2 (el mateix que al canó 1 invertit)
    (putprop 'cano2 (get 'escenari 'y3) 'cy)
    (putprop 'cano2 (+ (+(get 'escenari 'x2)(get 'escenari 'x3))20
    (random (-(-(get 'escenari 'x4)40)(+ (get 'escenari 'x2)
    (get 'escenari 'x3))))) 'cx)
    (putprop 'cano2 (DegtoRad -240) 'angle)
    (putprop 'cano2 (+(get 'cano2 'cx)10) 'px)
    (putprop 'cano2 (+(get 'cano2 'cy)10) 'py)

)

;funció per dibuixar la fletxa del vent
(defun fletxa(x y len)
    ;definim els atributs de la fletxa
    (putprop 'fletxa len 'length)
    (putprop 'fletxa x 'xf)
    (putprop 'fletxa y 'yf)
    (color 0 0 0)

    ;si el vent és positiu, la dibuixam cap a la dreta
    (cond ((> (get 'escenari 'vent) 0)
        (move x y)
        (drawrel len 0)
        (drawrel -10 10)
        (move (+ x len) y)
        (drawrel -10 -10)
        (move x y)
        ;dibuixam les retxes de la intensitat
        (retxetes(get 'escenari 'vent))
        )

        ;si el vent és negatiu, la dibuixam cap a l'esquerra
        ((<(get 'escenari 'vent) 0)
        (move x y)
        (drawrel len 0)
        (move x y)
        (drawrel 10 10)
        (move x y)
        (drawrel 10 -10)
        (move (+ x len) y)
        ;dibuixam les retxes de la intensitat
        (retxetes(get 'escenari 'vent))
        )
    )   
)

;funció per a dibuixar les retxes d'ntensitat del vent
(defun retxetes(n)
    ;si el vent és 0, no es dibuixa res
    (cond ((= n 0) nil)
        ;si el vent és positiu es dibuixen tantes
        ;retxes com intensitat té el vent
        ((>(get 'escenari 'vent) 0)
            (drawrel 0 -10)
            (move (+ (get 'fletxa 'xf) 3) (get 'fletxa 'yf) )
            (putprop 'fletxa (+ (get 'fletxa 'xf) n ) 'xf)
            (retxetes(- n 1))
        )
        
        ;si el vent és negatiu es dibuixen tantes
        ;retxes com intensitat té el valor absolut del vent
        ((<(get 'escenari 'vent) 0)
            (drawrel 0 -10)
            (move (- (+ (get 'fletxa 'length) 
            (get 'fletxa 'xf)) 3) (get 'fletxa 'yf))
            (putprop 'fletxa (+(get 'fletxa 'xf) n) 'xf)
            (retxetes(+ n 1))
        )
    )
)

;funció per a pujar el canó els graus que es passen per paràmetre
(defun puja (canyon graus)
    ;ens col·locam a la posició de l'inici de la punta del canó
    (move (get canyon 'px) (get canyon 'py))
    ;definim el color segons el color de fons
    (color (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b)
            (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b))
    ;redibuixam la punta del canó amb el color de fons (l'esborram)
    (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
          (realpart (round (*(sin (get canyon 'angle))15)))
    )
    ;definim el color del canó
    (color 255 0 0)

    ;per al canó 1
    (cond ((equal canyon 'cano)
            ;guardam el nou angle del canó
            (putprop canyon (+(DegtoRad graus) (get canyon 'angle)) 'angle)
            ;dibuixam la nova punta del canó
            (move (get canyon 'px) (get canyon 'py))
            (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
                (realpart (round (*(sin (get canyon 'angle))15)))
            )
          )
          ;per al canó 2
          ((equal canyon 'cano2)
          ;guardam el nou angle del canó
          (putprop canyon (- (get canyon 'angle)(DegtoRad graus)) 'angle)
          ;dibuixam la nova punta del canó
          (move (get canyon 'px) (get canyon 'py))
          (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
                (realpart (round (*(sin (get canyon 'angle))15)))
            )
          )
    )
    (goto-xy 0 0)
    (cleol)
    (color 0 0 0)

)

;funció per a baixar el canó els graus que es passen per paràmetre
(defun baixa (canyon graus)
    ;ens col·locam a la posició de l'inici de la punta del canó
    (move (get canyon 'px) (get canyon 'py))
    ;definim el color segons el color de fons
    (color  (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b)
        (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b))
    ;redibuixam la punta del canó amb el color de fons (l'esborram)
    (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
          (realpart (round (*(sin (get canyon 'angle))15)))
    )
    ;definim el color del canó
    (color 255 0 0)

    ;per al canó 1
    (cond ((equal canyon 'cano)
            ;guardam el nou angle del canó
            (putprop canyon (- (get canyon 'angle)(DegtoRad graus)) 'angle)
            ;dibuixam la nova punta del canó
            (move (get canyon 'px) (get canyon 'py))
            (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
                (realpart (round (*(sin (get canyon 'angle))15)))
            )
          )
          ;per al canó 2
         ((equal canyon 'cano2)
            ;guardam el nou angle del canó
            (putprop canyon (+(DegtoRad graus) (get canyon 'angle)) 'angle)
            ;dibuixam la nova punta del canó
            (move (get canyon 'px) (get canyon 'py))
            (drawrel (realpart (round (*(cos (get canyon 'angle))15)))
                (realpart (round (*(sin (get canyon 'angle))15)))
            )
        )
    )
    (goto-xy 0 0)
    (cleol)
    (color 0 0 0)

)



;funcio dedicada exclusivament a pintar tot l escenari
(defun redraw()
    ;emplenam el fons de l'escenari
    (emplena 0 0 640 400 (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b))
    ;emplenam el 1r rectagle
    (emplena 0 0 (get 'escenari 'x2) (get 'escenari 'y2) 116 56 0)

    ;emplenam el rectangle d'enmig
    (emplena (get 'escenari 'x2) 0 (get 'escenari 'x3)
    (get 'escenari 'y1) 116 56 0)

    ;emplenam el 3r rectangle
    (emplena (+(get 'escenari 'x3)(get 'escenari 'x2)) 0  
    (get 'escenari 'x4) (get 'escenari 'y3) 116 56 0)
    (color 0 0 0 (get 'colorfons 'r) (get 'colorfons 'g) (get 'colorfons 'b))
    (color 255 0 0)

    ;dibuixam els dos canons
    (emplena (get 'cano 'cx) (get 'cano 'cy) 20 10 255 0 0)

    (emplena (get 'cano2 'cx) (get 'cano2 'cy) 20 10 255 0 0)

    ;dibuixam les puntes dels dos canons
    (move (get 'cano 'px) (get 'cano 'py))
    (drawrel (realpart (round (*(cos (get 'cano 'angle))15)))
          (realpart (round (*(sin (get 'cano 'angle))15)))
    )

    (move (get 'cano2 'px) (get 'cano2 'py))
    (drawrel (realpart (round (*(cos (get 'cano2 'angle))15)))
          (realpart (round (*(sin (get 'cano2 'angle))15)))
    )
    (color 0 0 0)

    ;dibuixam la fletxa del vent
    (fletxa 30 310 40)
)

;funció que simula el dispar d'un canó
(defun simula (canyon speed)
;dispar del canó 1
(cond ((equal canyon 'cano)
;pr1x i pr1y són les posicions que anirem actualitzant per pintar
(putprop 'projectil1
(+(get 'cano 'px)(realpart (round (*(cos (get 'cano 'angle))15)))) 'pr1x)
(putprop 'projectil1
(+(get 'cano 'py)(realpart (round (*(sin (get 'cano 'angle))15)))) 'pr1y)
;guardam la posicio inicial per si la tornam a cridar que pinti de la punta.
(putprop 'projectil1 (get 'projectil1 'pr1x) 'inicialx)
(putprop 'projectil1 (get 'projectil1 'pr1y) 'inicialy)        

(move (get 'projectil1 'pr1x) (get 'projectil1 'pr1y))

(dispara 'cano speed 1)

(move (get 'projectil1 'inicialx) (get 'projectil1 'inicialy))

(goto-xy 0 0)
(cleol)
(color 0 0 0)
  
)

;dispar de canó 2
((equal canyon 'cano2)
(putprop 'projectil2
(+(get 'cano2 'px)(realpart (round (*(cos (get 'cano2 'angle))15)))) 'pr2x)
(putprop 'projectil2
(+(get 'cano2 'py)(realpart (round (*(sin (get 'cano2 'angle))15)))) 'pr2y)
;guardam la posicio inicial per si la tornam a cridar que pinti de la punta.
(putprop 'projectil2 (get 'projectil2 'pr2x) 'inicialx)
(putprop 'projectil2 (get 'projectil2 'pr2y) 'inicialy)        

(move (get 'projectil2 'pr2x) (get 'projectil2 'pr2y))

(dispara 'cano2 speed 1)

(move (get 'projectil2 'inicialx) (get 'projectil2 'inicialy))

(goto-xy 0 0)
(cleol)
(color 0 0 0)

)

)

)

;funció que dibuixa la trajectòria d'un dispar
(defun dispara (canyon speed time)
;calculam i guardam les diferents velocitats (fórmules tir parabòlic)
(putprop 'velocitat (* speed (cos (get canyon 'angle))) 'vox)
(putprop 'velocitat (* speed (sin (get canyon 'angle))) 'voy)
    (cond ((= 0 (get 'escenari 'vent))
            (putprop 'velocitat (get 'velocitat 'vox)'vx))

(t(putprop 'velocitat (+(get 'velocitat 'vox)
    (* time (get 'escenari 'vent)))'vx))

)

(putprop 'velocitat (+(* time -9.8)(get 'velocitat 'voy)) 'vy)
;amb les velocitats ja calculades, calculam la posició x i y
(putprop 'pos (*(get 'velocitat 'vx) time) 'x)
(putprop 'pos (+(* (get 'velocitat 'vy) time)(*(* time time) -9.8 0.5))'y)

;per al canó 1
(cond ((equal canyon 'cano)

    ;dibuixam fins al punt calculat
    (drawrel (realpart(round(+ time (get 'pos 'x))))
             (realpart(round(+ time (get 'pos 'y)))))

;actualitzam la posició    
(putprop 'pos (+ (get 'pos 'x)(get 'projectil1 'pr1x)) 'x)
(putprop 'projectil1 (get 'pos 'x) 'pr1x)
(putprop 'pos (+(get 'pos 'y)(get 'projectil1 'pr1y)) 'y)
(putprop 'projectil1 (get 'pos 'y)'pr1y)
    ;condicions d'acabament (per aturar de dibuixar)
    (cond 
        ((AND(< (get 'pos 'y)(get 'escenari 'y2))
        (<(get 'pos 'x)(get 'escenari 'x2)))nil)
          ((> (get 'pos 'x)(get 'escenari 'x4))nil)
          ((> (get 'pos 'y)390)nil)
          ((AND(>(get 'pos 'x)(get 'escenari 'x2))
            (<(get 'pos 'x)(+(get 'escenari 'x2)(get 'escenari 'x3)))
            (< (get 'pos 'y)(get 'escenari 'y1)))nil)
          ((AND(>(get 'pos 'x)(+(get 'escenari 'x2)(get 'escenari 'x3)))
          (< (get 'pos 'y)(get 'escenari 'y3)))nil)
((AND(= (get 'cano2 'cx)(get 'pos 'x))(<(get 'pos 'y)(get 'cano2 'py)))nil)
((AND (>= (get 'pos 'x)(get 'cano2 'cx))
          (<(get 'pos 'x)(+(get 'cano2 'cx)20))
          (=(get 'pos 'y)(get 'cano2 'py)))nil)
    ;tornam a cridar a la funció incrementant el temps
    (t(dispara 'cano speed (+ time 0.125))))

)
    ;per al canó 2
    ((equal canyon 'cano2)

    ;dibuixam fins al punt calculat
    (drawrel (realpart(round(+ time (get 'pos 'x))))
             (realpart(round(+ time (get 'pos 'y)))))

;actualitzam la posició      
(putprop 'pos (+ (get 'pos 'x)(get 'projectil2 'pr2x)) 'x)
(putprop 'projectil2 (get 'pos 'x) 'pr2x)
(putprop 'pos (+(get 'pos 'y)(get 'projectil2 'pr2y)) 'y)
(putprop 'projectil2 (get 'pos 'y)'pr2y)
    ;condicions d'acabament (per aturar de dibuixar)
    (cond 
        ((AND(< (get 'pos 'y)(get 'escenari 'y3))
        (>(get 'pos 'x)(+(get 'escenari 'x2)(get 'escenari 'x3))))nil)
          ((< (get 'pos 'x) 0)nil)
          ((> (get 'pos 'y)390)nil)
          ((AND(>(get 'pos 'x)(get 'escenari 'x2))
            (<(get 'pos 'x)(+(get 'escenari 'x2)(get 'escenari 'x3)))
            (< (get 'pos 'y)(get 'escenari 'y1)))nil)
          ((AND(<(get 'pos 'x)(get 'escenari 'x2))
          (< (get 'pos 'y)(get 'escenari 'y2)))nil)
((AND(= (get 'cano 'cx)(get 'pos 'x))(<(get 'pos 'y)(get 'cano 'py)))nil)
((AND (>= (get 'pos 'x)(get 'cano 'cx))
      (<(get 'pos 'x)(+(get 'cano 'cx)20))
      (=(get 'pos 'y)(get 'cano 'py)))nil)
    ;tornam a cridar a la funció incrementant el temps
    (t(dispara 'cano2 speed (+ time 0.125))))
        )
    )
)

;funció que crida a totes les funcions per dibuixar-ho tot
(defun pinta()
    (cls)
    (carregarEscenari)
    (carregarCanons)
    (redraw)
    (repetir(read))
)
