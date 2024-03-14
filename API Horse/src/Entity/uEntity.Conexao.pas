unit uEntity.Conexao;

interface
   uses system.SysUtils;

   type

   { SQl Server }
   TConexaoSQLServer = class
     private
      FDriverID : string;
      FUserName : string;
      FPassword : string;
      FDataBase : string;
      FServer   : string;

   public
     property DriverID : string read FDriverID;
     property UserName : string read FUserName;
     property Password : string read FPassword;
     property DataBase : string read FDataBase;
     property Server   : string read FServer;

     constructor Create;
   end;

   TConexaoMySQL = class
     private
      FDriverID : string;
      FUserName : string;
      FPassword :string;
      FDataBase : string;

   public
     property DriverID : string read FDriverID;
     property UserName : string read FUserName;
     property Password :string read FPassword;
     property DataBase :string read FDataBase;

     constructor Create;
   end;

   TConexaoSQLite = class
     private
      FDriverID : string;
      FUserName : string;
      FPassword :string;
      FDataBase : string;

   public
     property DriverID : string read FDriverID;
     property UserName : string read FUserName;
     property Password :string read FPassword;
     property DataBase :string read FDataBase;

     constructor Create;

   end;

implementation

{ TConexaoMySQl }

constructor TConexaoMySQl.Create;
begin
  FDriverID := 'MySQL';
  FUserName := 'root';
  FPassword := 'dominus';
  FDataBase := 'dominus';
end;

{ TConexaoSQLite }

constructor TConexaoSQLite.Create;
begin
  FDriverID := 'SQLite';
  FUserName := '';
  FPassword := '';
  FDataBase := ExtractFilePath(ParamStr(0))+ 'NomeBanco.DB';
end;

{ TConexaoSQLServer }

constructor TConexaoSQLServer.Create;
begin
  FDriverID := 'MSSQL';
  FUserName := '';
  FPassword := '';
  FDataBase := 'Tarefas';
  FServer   := 'DESKTOP-UME1TLL';
end;

end.
