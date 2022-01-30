@title Zeitraffer mit Anpassung
@param a Bilderanzahl
@default a 10
@param b Intervall in s
@default b 60
@param d Display an in s
@default d 2
@param e anpassen 1:ISO,2:Blende,3:Zeit,0
@default e 0
@param f ab Unterschied in % anpassen
@default f 20
@param g Histogrammbereich
@default g 200
@param z RAW speichern
@default z 0
if z>1 then z=1

print "Gesamtdauer [min]: " a*b/60
print "Abbrechen mit Menu"

G=g
m=get_capture_mode
if m<>5 and e>0 then print "Anpassung nur im Manual Mode moeglich"

select get_display_mode
  case 0; T=0
  case 1; T=1
  case 2; T=2
  case 3; T=3
end_select
rem if (d+2)>b then d=b-2

Z=get_raw
if z<>Z then set_raw z

if m=5 then
 print "Vorbereitung"
 shoot
 sleep(100)
 h=0
 t=get_histo_range 0 1023
 if t=-1 then 
  shot_histo_enable 1
  h=1
  shoot
  sleep(100)
 endif
 g=g-1
 do
  g=g+1
  u=get_histo_range 0 g
 until u>=f
 G=G-1
 do
  G=G+1
  v=get_histo_range 1023-G 1023
 until v>=f
 print "Dunkle px " u, "Helle px " v
 p=get_iso_mode
 q=get_av
 r=get_tv96
 P=p
 Q=q
 R=r
 print "Zeit2" R
endif

if d=0 then gosub "dispaus"
  
for i=1 to a-1
 print "Bild Nr " i,P,Q,R
 if m=5 then
  set_iso_mode P
  set_av Q
  set_tv96 R
 endif
 shoot
 
 if m=5 then
  sleep(100)
  U=get_histo_range 0 g
  V=get_histo_range 1023-G 1023
  print u,U,v,V
  if u>(U+f) and V>(v+f) then
    print "Bild dunkler machen"
    select e
     case 1; if P>1 then P=P-1
     case 2; if Q<18 then Q=Q+1
     case 3; if R<960 then R=R+32
    end_select
  endif
  if U>(u+f) and v>(V+f) then
    print "Bild heller machen"
    select e
     case 1; if P<7 then P=P+1
     case 2; if Q>9 then Q=Q-1
     case 3; if R>-576 then R=R-32
    end_select
  endif
 endif
 
 if b>d and d>0 then gosub "dispaus" 
 for j=1 to b
  wait_click 920
  t=is_pressed "menu"
  if t=1 then goto "ende"
  t=is_pressed "display"
  if t=1 then gosub "changedisp"
  if (j=(b-d) and d>0) then gosub "dispein"
 next j
next i

if d=0 then gosub "dispein"

print "letztes Bild"
if m=5 then
 set_iso_mode P
 set_av Q
 set_tv96 R
endif
shoot
goto "ende"

:changedisp
 U=get_display_mode
 if (U=2 or U=3) then gosub "dispein" else gosub "dispaus"
 print "letztes Bild: " i, " von " a
return

:dispaus
 do
  click "display"
  U=get_display_mode
 until (U=2 or U=3)
return

:dispein
 do
  click "display"
  U=get_display_mode
 until U=T
return

:restore
:ende
 set_raw Z
 U=get_display_mode
 if U<>T then gosub "dispein"
 playsound 4
 if h=0 then shot_histo_enable 0
end

