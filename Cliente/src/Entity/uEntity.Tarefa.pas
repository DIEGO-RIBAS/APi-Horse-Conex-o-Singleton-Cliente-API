unit uEntity.Tarefa;

interface

   uses System.Generics.Collections,
        System.SysUtils;

  type
    TEntityTarefa = class
      private
        FID                  : Integer;
        FIDUsuario           : integer;
        FDescricao           : string;
        FDThrLancamento      : string;
        FDThrPrevisaoTermino : string;
        FDThrInicio          : string;
        FDThrFinalizada      : string;
        FStatus              : integer;
      public
        property ID                  : Integer read FID                  write FID;
        property Descricao           : string  read FDescricao           write FDescricao;
        property IDUsuario           : integer read FIDUsuario           write FIDUsuario;
        property DThrLancamento      : string  read FDThrLancamento      write FDThrLancamento;
        property DThrPrevisaoTermino : string  read FDThrPrevisaoTermino write FDThrPrevisaoTermino;
        property DThrInicio          : string  read FDThrInicio          write FDThrInicio;
        property DThrFinalizada      : string  read FDThrFinalizada      write FDThrFinalizada;
        property Status              : integer read FStatus              write FStatus;
    end;

    TEntityListaTarefas = class
       private
          FListaTarefas: TObjectList<TEntityTarefa>;
          FEntityTarefa: TEntityTarefa;
       public
          property ListaTarefas : TObjectList<TEntityTarefa> read FListaTarefas  write FListaTarefas ;
          property Tarefa       : TEntityTarefa  read FEntityTarefa  write FEntityTarefa ;

          procedure AddTarefa(ATarefa : TEntityTarefa);

          constructor Create;
          destructor destroy;
     end;

implementation

{ TEntityListaTarefas }

procedure TEntityListaTarefas.AddTarefa(ATarefa: TEntityTarefa);
var
  i : Integer;
begin
  FListaTarefas.Add(TEntityTarefa.Create);
  I := FListaTarefas.Count -1;
  FListaTarefas[I].FID                  := ATarefa.FID;
  FListaTarefas[I].FIDUsuario           := ATarefa.FIDUsuario;
  FListaTarefas[I].FDescricao           := ATarefa.FDescricao;
  FListaTarefas[I].FDThrLancamento      := ATarefa.FDThrLancamento;
  FListaTarefas[I].FDThrPrevisaoTermino := ATarefa.FDThrPrevisaoTermino;
  FListaTarefas[I].FDThrInicio          := ATarefa.FDThrInicio;
  FListaTarefas[I].FDThrFinalizada      := ATarefa.FDThrFinalizada;
  FListaTarefas[I].FStatus              := ATarefa.FStatus;
end;

constructor TEntityListaTarefas.Create;
begin
  FListaTarefas := TObjectList<TEntityTarefa>.Create();
  FEntityTarefa := TEntityTarefa.Create;
end;

destructor TEntityListaTarefas.destroy;
begin
  FreeAndNil(FListaTarefas);
  FreeAndNil(FEntityTarefa);
end;

end.
