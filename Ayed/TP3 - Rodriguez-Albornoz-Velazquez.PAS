program TPFinalMOD;
uses crt;
type guarderias = record
     nombre: string[40];
     direccion: string[40];
     cantmascotas: integer;
     valorxdia : real;
     totcaniles: integer;
     end;

     clientes = record
     dni : string[8];
     nomyapel : string[40];
     facturacion: real;
     end;

     mascotas = record
     nomascota : string[6];
     dni : string[8];
     diaingreso : integer;
     diasalida : integer;
     mes : integer;
     anio : integer;
     canilasignado: integer;
     valorestadia : real;
     end;

     atenciones = record
     nromascota : integer;
     mesyanio : integer;
     descripcion: string[40];
     costo: real;
     end;

     calendarios= record
     mes:integer;
     anio:integer;
     dias:array[1..31,1..25] of string;
     precio:real;
     end;

var g: file of guarderias;
    c: file of clientes;
    m: file of mascotas;
    a: file of atenciones;
    ca:file of calendarios;
    regg:guarderias;
    regc:clientes;
    regm:mascotas;
    rega:atenciones;
    regca:calendarios;
    op: integer;
    ba: integer;
    resp:char;
    auxnom:string[40];
    auxdir:string[40];
    auxtot:integer;
    cont:integer;
    ult:integer;
    b:boolean;
    dni:string[8];
    dni2:string[8];
    i:integer;
    j:integer;
    nya:string[40];
    nya2:string[40];
    fac:real;
    fac2:real;


procedure asignar;
begin
assign (g, 'c:\guarderias.dat');
assign (c, 'c:\clientes.dat');
assign (m, 'c:\mascotas.dat');
assign (a, 'c:\atenciones.dat');
assign (ca, 'c:\calendarios.dat');
end;

procedure menu;
begin
writeln ('1) Generar la guarderia (o modificar valor de estadia)');
writeln ('2) Crear mes de guarderia');
writeln ('3) Alta de clientes');
writeln ('4) Alta de mascotas');
writeln ('5) Alta de atencion');
writeln ('6) Facturacion');
writeln ('7) Recaudacion por mes');
writeln ('0) salir');
end;


procedure genguarderia;
begin
ba := 0;
{$I-} ;
reset (g);
if ioresult= 2 then
begin
rewrite (g);
while ba = 0 do
      begin
       writeln ('ingrese nombre de guarderia');
       readln (regg.nombre);
       writeln ('ingrese direccion de guarderia');
       readln (regg.direccion);
       writeln ('ingrese valor por dia');
       readln (regg.valorxdia);
       repeat
       writeln ('ingrese cantidad de caniles menor a 25');
       readln (regg.totcaniles);
       auxtot:=regg.totcaniles;
       until (auxtot>=1) and (auxtot <= 25);
       write (g,regg);
       writeln ('Guarderia creada satisfactoriamente');
       ba:=1;
       end;
end
else
writeln ('Desea modificar el valor de la estadia? S para si, N para no');
readln (resp);
       if resp = 's' then
       begin
       seek(g,0);
       read(g,regg);
       auxnom:=regg.nombre ;
       auxdir:=regg.direccion;
       auxtot:=regg.totcaniles;
       writeln ('ingrese valor por dia');
       readln (regg.valorxdia);
       regg.nombre:=auxnom;
       regg.direccion:=auxdir;
       regg.totcaniles:=auxtot;
       write (g,regg);
       end  ;
{$I+};
       writeln(regg.nombre);
       writeln(regg.direccion);
       writeln('$',regg.valorxdia:4:2);
       writeln(regg.totcaniles);
       readkey;
end;

procedure di(x:integer);
begin
     reset (g);
     read (g,regg);
     auxtot:=regg.totcaniles;
                  readkey;
     for i:=1 to 31 do
         for j:=1 to 25 do
          regca.dias[i,j]:='xxxxx';
     for i:= 1 to x do
         for j:=1 to auxtot do
             regca.dias[i,j]:=' '
end;


procedure verdias;
begin
  if (regca.mes=1) or (regca.mes=3) or (regca.mes=5) or (regca.mes=7) or (regca.mes=8) or (regca.mes=10) or (regca.mes=12) then
    begin
     di(31) ;
    end
  else if (regca.mes=4) or (regca.mes=6) or (regca.mes=9) or (regca.mes=11) then
          di(30)
       else if (regca.anio mod 4 =0) then
              di(29)
            else di(28)
end;

procedure crearmesg;
begin
   {$I-} ;
    reset(ca);
     if IOresult = 2 then
    begin
          rewrite(ca);
     end ;
     {$I+};
     if (filesize(ca)=0) then
        begin
             repeat
                   writeln('ingrese el mes de inicio');
                   readln(regca.mes);
             until (regca.mes >= 1) and (regca.mes<=12);
             writeln('ingrese anio de inicio');
             readln(regca.anio);
             verdias;
             writeln('se genero inicio en mes: ',regca.mes,' año: ',regca.anio);
        end
        else
        begin
            ult:=filesize(ca)-1;
            seek (ca,ult);
            read(ca,regca);
            if regca.mes <> 12 then
               regca.mes:=regca.mes+1
            else
            begin
                 regca.mes:=1;
                 regca.anio:=regca.anio+1;
            end;
            verdias;
            writeln('se genero el mes: ',regca.mes,' año: ',regca.anio);
            ult:=filesize(ca);
            seek(ca,ult);
            end;
     reset(g);
     read(g,regg);
     regca.precio:=regg.valorxdia;
     write(ca,regca);
     delay(3000);
     ClrScr
end;

procedure mostrarcli;
begin
cont:=0;
ult:=filesize(c);
repeat
      seek(c,cont);
      read(c,regc);
      write(cont,'  ');
      write(regc.dni,'  ');
      writeln(regc.nomyapel);
      cont:=cont+1;
until cont=ult;
end;

procedure ordenar;
begin
     ult:=filesize(c);
     for i:=0 to ult-2 do
     begin
          for j:=i+1 to ult-1 do
          begin
               seek(c,i);
               read(c,regc);
               nya:=regc.nomyapel;
               fac:=regc.facturacion;
               dni:=regc.dni;
               seek(c,j);
               read(c,regc);
               dni2:=regc.dni;
               nya2:=regc.nomyapel;
               fac2:=regc.facturacion;
               if dni>dni2 then
               begin
                    seek(c,i);
                    regc.dni:=dni2;
                    regc.nomyapel:=nya2;
                    regc.facturacion:=fac2;
                    write(c,regc);
                    seek(c,j);
                    regc.dni:=dni;
                    regc.nomyapel:=nya;
                    regc.facturacion:=fac;
                    write(c,regc);
               end;

          end
     end;

end;

function buscar(dni:string[8]):boolean;
begin
reset(c);
b:=false;
repeat
read(c,regc);
      if regc.dni=dni then
      b:=true
until (b=true) or eof(c) ;
if b=true then
begin
buscar:=true;
end
else
begin
buscar:=false;
end
end;

procedure alta;
begin
writeln('Ingrese nombre y apellido: ');
readln(regc.nomyapel);
regc.dni:=dni;
seek(c,filesize(c));
write(c,regc)
end;

procedure altacli;
begin
{$I-} ;
reset(c);
if IOresult = 2 then
     begin
          rewrite(c);
     end;
{$I+};
writeln('ingrese dni del cliente');
read(dni);
if filesize(c)=0 then
   begin
   write('Ingrese nombre y apellido: ');
   readln(regc.nomyapel);
   regc.dni:=dni;
   write(c,regc);
   writeln('Cliente Guardado')
end
else
    begin
    reset(c);
    if buscar(dni) then
       begin
       writeln('ese cliente ya fue cargado')
       end
    else
    begin
        alta;
        writeln('cliente guardado.')
        end
    end;
    ordenar;
    mostrarcli;
end;

procedure altamasc;
begin
end;

procedure altasat;
begin
end;

procedure facturacion;
begin
end;

procedure recaudacion;
begin
end;

procedure cierre;
begin
close (g);
close (c);
close (m);
close (a);
close (ca);
end;

begin
asignar;
repeat
      repeat
            menu;
            readln (op);
      until (op>=0) and (op<=7);
      case op of
      1: genguarderia;
      2: crearmesg;
      3: altacli;
      4: altamasc;
      5: altasat;
      6: facturacion;
      7: recaudacion
      end;
until op=0;
cierre;
readkey;
end.
