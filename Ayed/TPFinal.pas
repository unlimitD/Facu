program TPFinal;
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
    ba: char;



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
end;


procedure genguarderia;
begin
{$I-}  ;
reset (g);
if ioresult= 2 then
rewrite (g);
{$I+};
read (g, regg);
ba := '0';
while ba = '0' do
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
       ba:='1';
       end;
readkey;
end;

procedure crearmesg;
begin
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
      until (op>=1) and (op<=7);
      case op of
      1: genguarderia;
      2: crearmesg;
      3: altacli;
      4: altamasc;
      5: altasat;
      6: facturacion;
      7: recaudacion
      end;
until op=7;
cierre;
readkey;
end.
