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
     fact: real;
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
    med:integer;
    b:boolean;
    dni:string[8];



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
writeln ('0) Salir');
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
       auxnom:=regg.nombre ;
       auxdir:=regg.direccion;
       auxtot:=regg.totcaniles;
       writeln ('ingrese valor por dia');
       readln (regg.valorxdia);
       regg.nombre:=auxnom;
       regg.direccion:=auxdir;
       regg.totcaniles:=auxtot;
       write (g,regg);
       end ;
{$I+};
       write(regg.nombre);
       write('  ',regg.direccion,'  ');
       write('  $',regg.valorxdia:4:2);
       writeln('  ',regg.totcaniles);
readkey;
end;

procedure crearmesg;
begin
end;

function dico : boolean;
begin
ini:=0;
fin:=filesize(c);
b:=false;
repeat
      med:=(ini+fin)div 2;
      seek (c, med);
      read (c, regc);
      if regc.dni = dni then
      begin
      b:=true
      end
      else
      begin
      if dni>regc.dni then
      begin
         fin:=med-1;
      end
         else
         begin
         ini:=med+1;
         end;
      end;
until (ini>fin) or b;
if b = true  then
begin
dico:=true ;
end
else
begin
dico:=false;
end;
end;


procedure altacli;
begin

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
