program TP3VentolaKevin_BotelloAndres;
uses crt;
type guar=record
           nom:string[40];
           dir:string[40];
           tot_can:integer;
           num_mas:integer;
           ppd:real
          end;

     cli=record
           dni:string[8];
           nomyap:string[40]
         end;

     mas=record
           num_mas:integer;
           nom_mas:string[6];
           dni_cli:string[8];
           can_asig:integer;
           val_est:real;
           dia_in:integer;
           dia_eg:integer;
           mes:integer;
           anio:integer
         end;

     cal=record
           mes:integer;
           anio:integer;
           dias:array[1..31,1..25]of string;
           precio:real
         end;

     ate=record
           num_mas:integer;
           mes:integer;
           anio:integer;
           desc:string[40];
           costo:real;
           dni_cli:string[8];
           nom_mas:string[6]
         end;

var  g:file of guar; rg:guar;
     ca:file of cal; rca:cal;
     cl:file of cli; rcl:cli; rcl2:cli;
     m:file of mas; rm:mas;
     a:file of ate; ra:ate;

     n,i,k,con,mes,anio,num_mas, dia_in, dia_eg, num_can, eend, op:integer;
     tg, sum, sumtot, sumtot2: real;
     r,res:char;
     vv,xx,bb,flag:boolean;
     dni:string[8];
     nom:string[6];

PROCEDURE ABRIR;
begin
     assign(g,'C:\guarderias.dat');
     {$I-}                            // anula la visión del error si no existe el archivo físico
     reset(g);                      // intento posicionarme al comienzo del archivo
     if ioresult=2 then rewrite(g) // si el resultado es distinto de cero, debe crearlo fisicamente porque no existe
                   else seek (g, filesize(g)); // si existe me posiciono al final del archivo
     {$I+}                            // habilita nuevamente la función input output error.

     assign(ca,'C:\calendarios.dat');
     {$I-}                            // anula la visión del error si no existe el archivo físico
     reset(ca);                      // intento posicionarme al comienzo del archivo
     if ioresult=2 then rewrite(ca) // si el resultado es distinto de cero, debe crearlo fisicamente porque no existe
                   else seek (ca, filesize(ca)); // si existe me posiciono al final del archivo
     {$I+}                            // habilita nuevamente la función input output error.

     assign(cl,'C:\clientes.dat');
     {$I-}                            // anula la visión del error si no existe el archivo físico
     reset(cl);                      // intento posicionarme al comienzo del archivo
     if ioresult=2 then rewrite(cl) // si el resultado es distinto de cero, debe crearlo fisicamente porque no existe
                   else seek (cl, filesize(cl)); // si existe me posiciono al final del archivo
     {$I+}                            // habilita nuevamente la función input output error.

     assign(m,'C:\mascotas.dat');
     {$I-}                            // anula la visión del error si no existe el archivo físico
     reset(m);                      // intento posicionarme al comienzo del archivo
     if ioresult=2 then rewrite(m) // si el resultado es distinto de cero, debe crearlo fisicamente porque no existe
                   else seek (m, filesize(m)); // si existe me posiciono al final del archivo
     {$I+}                            // habilita nuevamente la función input output error.

     assign(a,'C:\atenciones.dat');
     {$I-}                            // anula la visión del error si no existe el archivo físico
     reset(a);                      // intento posicionarme al comienzo del archivo
     if ioresult=2 then rewrite(a) // si el resultado es distinto de cero, debe crearlo fisicamente porque no existe
                   else seek (a, filesize(a)); // si existe me posiciono al final del archivo
     {$I+}                            // habilita nuevamente la función input output error.

end;

PROCEDURE CERRAR;
begin
     close(g);
     close(ca);
     close(cl);
     close(m);
     close(a)
end;

PROCEDURE OPCION1;
begin
     if filesize (g)=0 then begin
                                 write('Ingrese nombre de guarderia: ');
                                 readln(rg.nom);
                                 write('Ingrese direccion: ');
                                 readln(rg.dir);
                                 repeat
                                 write('Ingrese total de caniles, menor a 26: ');
                                 readln(rg.tot_can)
                                 until (rg.tot_can>=1)and(rg.tot_can<=25);
                                 n:=rg.tot_can;
                                 rg.num_mas:=0;
                                 repeat
                                 write('Ingrese valor de la estadia diaria: ');
                                 readln(rg.ppd)
                                 until(rg.ppd>0);
                                 write(g,rg)
                            end
                       else begin
                            reset(g);
                            read(g,rg);
                            writeln('Guarderia ',rg.nom);
                            writeln('Direccion: ',rg.dir);
                            writeln('Caniles: ',rg.tot_can);
                            writeln('Total de Mascotas: ',rg.num_mas);
                            writeln('Precio de la estadia diaria: $',rg.ppd:5:2);
                            repeat
                                  write('Desea modificar el valor de la estadia?(S o N): ');
                                  readln(res)
                            until (res='s')or(res='S')or(res='n')or(res='N');
                            if (res='s')or(res='S') then
                                                        begin
                                                             repeat
                                                             write('Ingrese nuevo valor de la estadia diaria: ');
                                                             readln(rg.ppd)
                                                             until(rg.ppd>0);
                                                             seek(g,filesize(g)-1);
                                                             write(g,rg)
                                                        end
                            end;
                            {writeln('Presione alguna tecla para regresar al menu principal: ');
                            readkey;}
                            ClrScr
end;

PROCEDURE GEN(x:integer);
begin
     for K:=1 to 31 do
         for I:=1 to 25 do
             rca.dias[k,i]:='xxxxx';
     for K:=1 to x do
         for I:=1 to n do
             rca.dias[k,i]:=' '
end;

PROCEDURE MESES;
begin
     if (rca.mes=1)or (rca.mes=3)or (rca.mes=5)or (rca.mes=7)or (rca.mes=8)or (rca.mes=10)or (rca.mes=12) then
                                                                                                              gen(31)
                                                                                                          else
                                                                                                              if (rca.mes=4)or (rca.mes=6)or (rca.mes=9)or (rca.mes=11) then gen(30)
                                                                                                                                                                        else if (rca.anio mod 4=0) then
                                                                                                                                                                                                       gen(29)
                                                                                                                                                                                                   else
                                                                                                                                                                                                       gen(28)
end;

PROCEDURE OPCION2;
begin
     if (filesize(ca)=0) then
                             begin
                                  repeat
                                        write('Ingrese mes inicial: ');
                                        readln(rca.mes);
                                  until (rca.mes>=1) and (rca.mes<=12);
                                  write('Ingrese anio inicial: ');
                                  readln(rca.anio);
                                  MESES;
                                  writeln('Se ha generado el mes ',rca.mes,' del anio ',rca.anio)
                             end
                         else
                             begin
                                  seek (ca,filesize(ca)-1);
                                  read(ca,rca);
                                  if rca.mes<>12 then rca.mes:=rca.mes+1
                                                 else begin
                                                           rca.mes:=1;
                                                           rca.anio:=rca.anio+1
                                                      end;
                                  MESES;
                                  writeln('Se ha generado el mes ',rca.mes,' de ',rca.anio);
                                  seek(ca,filesize(ca))
                             end;
     reset(g);
     read(g,rg);
     rca.precio:=rg.ppd;
     write(ca,rca);
     delay(3000);
     ClrScr
end;


PROCEDURE ORDENAR;
begin
     for k:= 0 to filesize(cl)-2 do
         for i:=(k+1) to filesize(cl)-1 do
                                        begin
                                             seek(cl,k);
                                             read(cl,rcl);
                                             seek(cl,i);
                                             read(cl,rcl2);
                                             if rcl.dni>rcl2.dni then begin
                                                                           seek(cl,k);
                                                                           write(cl,rcl2);
                                                                           seek(cl,i);
                                                                           write(cl,rcl)
                                                                      end
                                        end
end;

PROCEDURE ALTACLI;
begin
     rcl.dni:=dni;
     writeln('Ingrese nombre y apellido: ');
     readln(rcl.nomyap);
     seek(cl,filesize(cl));
     write(cl,rcl)
end;

FUNCTION BUSQUEDA(DNI:string[8]):boolean;
begin
     if filesize(cl)>0 then begin
                                 reset(cl);
                                 flag:=false;
                                 repeat
                                       read(cl,rcl);
                                       if rcl.dni=dni then flag:=true
                                 until (flag=true) or eof(cl)
                            end;
    if flag=true then BUSQUEDA:=FALSE
                 else BUSQUEDA:=TRUE
end;

PROCEDURE NUEVOCLI;
begin
     if filesize(cl)=0 then begin
                                 rcl.dni:=dni;
                                 write('Ingrese nombre y apellido: ');
                                 readln(rcl.nomyap);
                                 write(cl,rcl);
                                 writeln('Cliente Guardado')
                            end
                       else begin
                                 reset(cl);
                                 if BUSQUEDA(dni) then begin
                                                            ALTACLI;
                                                            writeln('Cliente guardado.')
                                                       end
                                                  else writeln(rcl.nomyap,' ya fue cargado')
                            end;
end;

PROCEDURE OPCION3;
begin
     repeat
           write('Ingrese DNI: ');
           readln(dni);
           NUEVOCLI;
           repeat
                 write('Desea dar de alta otro cliente?(S)(N)');
                 readln(r)
           until (r='s')or(r='S')or(r='n')or(r='N')
     until (r='n') or (r='N');
     ORDENAR;
     ClrScr
end;


FUNCTION BUSCAMAS(num_mas:integer):boolean;
begin
     seek(m,num_mas-1);
     read(m,rm);
     if rm.num_mas=num_mas then BUSCAMAS:=true
                     else BUSCAMAS:=false
end;

PROCEDURE OPCION5;
begin
     repeat
     write('Ingrese numero de mascota: ');
     readln(num_mas)
     until (num_mas>0);
     reset(g);
     read(g,rg);
     if num_mas<=rg.num_mas then begin
                                    BUSCAMAS(num_mas);
                                    repeat
                                          write('Ingrese mes: ');
                                          readln(ra.mes)
                                    until (ra.mes>=1) and (ra.mes<=12);
                                    write('Ingrese anio: ');
                                    readln(ra.anio);
                                    write('Ingrese atenciones a realizar: ');
                                    readln(ra.desc);
                                    ra.dni_cli:=rm.dni_cli;
                                    write('Ingrese costo de atencion: ');
                                    readln(ra.costo);
                                    ra.nom_mas:=rm.nom_mas;
                                    if filesize(a)<>0 then
                                                          seek(a,filesize(a));
                                    write(a,ra)
                               end
                          else write('Numero de mascota no encontrado.');
                 delay(2000);
                 clrscr
end;

PROCEDURE SUMAMES;
begin
     for K:=1 to 31 do
         for I:=1 to 25 do
             if (rca.dias[k,i]<>' ') and (rca.dias[k,i]<>'xxxxx') then con:=con+1
end;

PROCEDURE OPCION7;
begin
     con:=0;
     sum:=0;
     xx:=false;
     repeat
           write('Ingrese mes: ');
           readln(mes)
     until (mes>=1) and (mes<=12);
     write('Ingrese anio: ');
     readln(anio);
     reset(ca);
     while not eof(ca) and (xx=false) do
                                        begin
                                             read(ca,rca);
                                             if (rca.anio=anio)and(rca.mes=mes) then begin
                                                                                          SUMAMES;
                                                                                          xx:=true
                                                                                     end
                                        end;
     tg:=con*rca.precio;
     reset(a);
     while not eof(a) do
                        begin
                             read(a,ra);
                             if (ra.mes=mes)and(ra.anio=anio) then sum:=sum+ra.costo
                        end;
     if xx=false then writeln('Mes y Anio no encontrados')
                 else
                     begin
                          writeln('El total recaudado en la guarderia en el mes ',mes,' fue de $',tg:2:2);
                          writeln('El total recaudado por atencion a mascotas en el mes ',mes,' fue de $',sum:2:2);
                          writeln('En el mes ',mes,' de ',anio,' se recaudo un total de $',tg+sum:2:2)
                     end;
     readkey;
     {delay(4000);}
     clrscr
end;



PROCEDURE OPCION6;
begin
     sumtot:=0;
     sumtot2:=0;
     repeat
           write('Ingrese mes: ');
           readln(mes)
     until (mes>=1)and(mes<=12);
     write('Ingrese anio: ');
     readln(anio);
     write('Ingrese DNI: ');
     readln(dni);
     if BUSQUEDA(DNI)=false then begin
                                reset(m);
                                while not eof(m) do begin
                                                         read(m,rm);
                                                         if (rm.mes=mes) and(rm.anio=anio) and(rm.dni_cli=dni) then begin
                                                                                                                         sumtot:=sumtot+rm.val_est;
                                                                                                                         writeln(rm.nom_mas,': $ ',rm.val_est:2:2,' por guarderia.')
                                                                                                                    end
                                                     end;
                                reset(a);
                                while not eof(a) do begin
                                                         read(a,ra);
                                                         if (ra.dni_cli=dni) then begin
                                                                                 sumtot2:=sumtot2+ra.costo;
                                                                                 writeln(ra.nom_mas, ': $ ',ra.costo:2:2,' por ',ra.desc)
                                                                            end
                                                     end;
                                seek(ca,filesize(ca)-1);
                                read(ca,rca);
                                if rca.anio>=anio then begin
                                                           writeln('Total guarderia: $',sumtot:2:2);
                                                           writeln('Total atenciones: $',sumtot2:2:2);
                                                           writeln('Total: $',sumtot+sumtot2:2:2)
                                                       end
                                                 else writeln('Anio no encontrado')
                           end
                           else writeln('Cliente no encontrado.');
      readkey;
      clrscr
end;

PROCEDURE MUESTROMES;
begin
     write('Dia/Canil');
     for k:=1 to n do
         write(k);
     writeln;
     for k:=1 to 31 do
                      begin
                           if k<10 then write(k,' ')
                                   else write(k);
                           for i:=1 to n do
                               write(' ','|',rca.dias[k,i]:6,'|');
                           writeln
                      end
end;

PROCEDURE MOSTRAR;
begin
     bb:=false;
     reset(ca);
     while (not eof(ca)) and (bb=false) do
                                          begin
                                               read(ca,rca);
                                               if (rca.mes=mes) and (rca.anio=anio) then begin
                                                                                              MUESTROMES;
                                                                                              bb:=true
                                                                                         end;
                                          end;
     if eof(ca) then if bb then
                           else eend:=1;
end;

PROCEDURE ALTAMAS;
begin
     if filesize(m)>0 then begin
                                reset(m);
                                read(m,rm);
                                rm.nom_mas:=nom;
                                rm.dni_cli:=dni;
                                rm.can_asig:=num_can;
                                rm.dia_in:=dia_in;
                                rm.dia_eg:=dia_eg;
                                rm.mes:=mes;
                                rm.anio:=anio;
                                reset(g);
                                read(g,rg);
                                rm.val_est:=((dia_eg-dia_in+1)*rg.ppd);
                                rg.num_mas:=rg.num_mas+1;
                                rm.num_mas:=rg.num_mas;
                                seek(g,filepos(g)-1);
                                write(g,rg);
                                seek(m,filesize(m));
                                write(m,rm)
                           end
                      else begin
                                rm.nom_mas:=nom;
                                rm.dni_cli:=dni;
                                rm.can_asig:=num_can;
                                rm.dia_in:=dia_in;
                                rm.dia_eg:=dia_eg;
                                rm.mes:=mes;
                                rm.anio:=anio;
                                reset(g);
                                read(g,rg);
                                rm.val_est:=((dia_eg-dia_in+1)*rg.ppd);
                                rg.num_mas:=rg.num_mas+1;
                                rm.num_mas:=rg.num_mas;
                                seek(g,filepos(g)-1);
                                write(g,rg);
                                write(m,rm)
                           end
end;

PROCEDURE CARGOMES;
begin
     for K:=dia_in to dia_eg do
         begin
         rca.dias[k,num_can]:=nom
         end
end;

PROCEDURE CARGAR;
begin
     write('Ingrese nombre: ');
     readln(nom);
     bb:=false;
     seek(ca,0);
     while (bb=false) do
                      begin
                           read(ca,rca);
                           if (rca.mes=mes) and (rca.anio=anio) then begin
                                                                          CARGOMES;
                                                                          bb:=true;
                                                                     end
                      end;
     seek(ca,filepos(ca)-1);
     write(ca,rca)
end;

FUNCTION VALIDAR(dia_in,dia_eg,num_can:integer):boolean;
begin
     vv:=true;
     for K:=dia_in to dia_eg do
                               if (rca.dias[k,num_can]<>' ') then vv:=false;
     if vv then VALIDAR:=true
           else VALIDAR:=false;
end;


PROCEDURE OPCION4;
begin
     repeat
           write('Ingrese mes: ');
           readln(mes)
     until (mes>=1) and (mes<=12);
     write('Ingrese anio: ');
     readln(anio);
     MOSTRAR;
     if eend<>1 then begin
                     repeat
                           repeat
                                 write('Ingrese dia de ingreso: ');
                                 readln(dia_in);
                           until (dia_in>=1)and(dia_in<=31);
                           repeat
                                 write('Ingrese dia de egreso: ');
                                 readln(dia_eg);
                           until (dia_eg>=1)and(dia_eg<=31)and(dia_eg>=dia_in);
                           repeat
                                 write('Ingrese numero de canil: ');
                                 readln(num_can);
                           until (num_can>=1)and(num_can<=n)
                     until VALIDAR(dia_in,dia_eg,num_can);
                     if VALIDAR(dia_in,dia_eg,num_can) then CARGAR;
                     write('Ingrese DNI del cliente: ');
                     readln(dni);
                     if BUSQUEDA(dni) then begin
                                                altacli;
                                                altamas
                                           end
                                      else altamas
                     end    ;

                     mostrar;
                     delay(4000);
                     clrscr
end;




begin
      abrir;
      if filesize(g)>0 then begin
                                 reset(g);
                                 read(g,rg);
                                 n:=rg.tot_can
                            end;
      repeat
            textbackground(1);
            writeln;
            gotoxy(20,2);writeln('\\\MENU DE OPCIONES///');
            gotoxy(20,3);writeln('**********************');
            gotoxy(10,5);writeln('1: Generar guarderia o modificar valor de estadia.');
            gotoxy(10,6);writeln('2: Crear mes de guarderia.');
            gotoxy(10,7);writeln('3: Alta de clientes.');
            gotoxy(10,8);writeln('4: Alta de mascotas.');
            gotoxy(10,9);writeln('5: Altas de atencion.');
            gotoxy(10,10);writeln('6: Facturacion.');
            gotoxy(10,11);writeln('7: Recaudacion por mes.');
            gotoxy(10,12);writeln('0: Salir.');
            writeln;
            write('Ingrese una opcion: ');
            repeat
            readln(op)
            until (op>=0)and(op<=7);
            case op of
            1:opcion1;
            2:opcion2;
            3:opcion3;
            4:opcion4;
            5:opcion5;
            6:opcion6;
            7:opcion7;
            0:cerrar
            end
      until (op=0);
readkey
end.
