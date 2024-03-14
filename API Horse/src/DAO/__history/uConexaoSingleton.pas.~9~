unit uConexaoSingleton;

interface
  Uses
  System.SysUtils,

  FireDAC.DApt,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  Data.DB,
  FireDAC.Comp.Client,

  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,

  {My Units}
  uEntity.Conexao ;

  type

    TInstanciaConexao = class(TConexaoSQLServer)
      private
        Fcon : TFDConnection;
        FdPhysMSSQL : TFDPhysMSSQLDriverLink;

        {SQLite}
        FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;

      public
        class Function ObterInstancia : TInstanciaConexao;
        property Conexao : TFDConnection read FCon;

        constructor Create;
    end;

implementation

  var
    InstanciaDB : TInstanciaConexao;

constructor TInstanciaConexao.Create;
var
  ConexaoSQLServer : TConexaoSQLServer;
begin
  inherited;

  ConexaoSQLServer := TConexaoSQLServer.Create;

  FCon := TFDConnection.Create(Nil);

  { Conexão SQLite }
  try
    with ConexaoSQLServer do
    begin
      with FCon do
      begin
{        Params.DriverID := DriverID;
        Params.UserName := UserName;
        Params.Password := Password;
        Params.Database := DataBase;}

        Params.Clear;
        Params.Values['DriverID']  := 'MSSQL';
        Params.Values['Server']    := Server;
        Params.Values['Database']  := DataBase;
        Params.Values['User_name'] := UserName;
        Params.Values['Password']  := Password;
      end;
    end;
  finally
    FreeAndNil(ConexaoSQLServer);
  end;

  try
    Fcon.Connected := True;
  except on E : Exception do
     begin
       raise Exception.Create('Erro na conexão :'+E.Message);
     end;
  end;
end;

class function TInstanciaConexao.ObterInstancia: TInstanciaConexao;
begin
  if InstanciaDB = nil then
    InstanciaDB := TInstanciaConexao.Create;

  Result := InstanciaDB;
end;

end.
