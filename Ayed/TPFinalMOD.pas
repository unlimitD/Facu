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

var g: file of guarderias;
    c: file of clientes;
    m: file of mascotas;
    a: file of atenciones;
    regg:guarderias;
    regc:clientes;
    regm:mascotas;
    rega:atenciones;
    op: integer;
    ba: integer;
    resp:char;
    auxnom:string[40];
    auxdir:string[40];
    auxtot:integer;
    cont:integer;
    ult:integer;
    ini:integer;
    fin:integer;
    b:boolean;
    med:integer;
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
       writeln ('ingrese cantidad de caniles');
       readln (regg.totcaniles);
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

procedure crearmesg;
begin
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
   buscar:=true
   else
   buscar:=false
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


procedure alta;
begin
regc.dni:=dni;
writeln('Ingrese nombre y apellido: ');
readln(regc.nomyapel);
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
writeln('ingrese DNI del cliente');
read(dni);
if filesize(c)=0 then begin
write('Ingrese nombre y apellido: ');
readln(regc.nomyapel);
regc.dni:=dni;
write(c,regc);
writeln('Cliente Guardado')
end
else
begin
reset(c);
if buscar(dni) then begin
writeln(' ya fue cargado')
end
else
alta;
writeln('Cliente guardado.')
end;

ordenar;
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
