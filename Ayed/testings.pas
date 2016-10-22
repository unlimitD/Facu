program aaa;
uses crt;
type
    Hola=record
               a:string[40];
               b:integer;
               c:char;
end;
var
   Hi: file of Hola;
   ult:integer;
   cont: integer;
   reg:Hola;

begin
     assign (Hi,'c:\hola.dat');
     {$i-};
     if IOresult = 2 then
        rewrite(Hi);
     else
     reset(Hi);
     end;
       {$i+};
          ult:= filesize(Hi);
          seek(Hi,ult);
          writeln('Existen ', ult, ' registros');
          writeln('ingrese un string');
          readln (reg.a);
          writeln('ingrese un entero');
          readln (reg.b);
          writeln('ingrese un caracter');
          readln (reg.c);
          write (Hi,reg);
          cont:=0 ;
         //reset del archivo
         // un read del archivo y el reg
         // exibir los campos
        reset(Hi);
        repeat
           read(Hi,reg);
           writeln('');
           writeln(reg.a);
           writeln(reg.b);
           writeln(reg.c);
           cont:=cont+1
        until cont = ult+1 ;
readkey;
close(Hi);
end.
