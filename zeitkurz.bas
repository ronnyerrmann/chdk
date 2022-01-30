@title schneller Zeitraffer
@param a Bilderanzahl
@default a 10
@param b Fokustests
@default b 5
@param z RAW speichern
@default z 0
if z>1 then z=1

select get_display_mode
  case 0; T=0
  case 1; T=1
  case 2; T=2
  case 3; T=3
end_select

Z=get_raw
if z<>Z then set_raw z

F=get_focus_mode
if F=0 then
 f=0
 for i=1 to b
  do
   press "shoot_half"
   sleep 150
   release "shoot_half"
   g=get_focus
  until g>0
  f=f+g
  print g,f
  sleep 20
 next i
 f=f/b
 print "Fokus=" f
 click "mf"
 sleep 30
endif

if T<2 then
  do
  click "display"
  U=get_display_mode
 until (U=2 or U=3)
endif

for i=1 to a
 set_focus f
 shoot
next i

:restore
set_raw Z
if F=0 then
 do
  click "mf"
  f=get_focus_mode
 until f=F
endif
U=get_display_mode
if U<>T then
 do
  click "display"
  U=get_display_mode
 until U=T
endif
playsound 4
end
