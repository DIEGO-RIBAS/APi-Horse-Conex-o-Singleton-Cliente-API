unit uEntity.Tarefa;

interface

  type

    TEntityTarefa = class
      private
        { Eu gosto de identar assim, acho mais facil pra ler o c�digo, mas caso precise que deixe sem espa�o, pra mim tudo bem }
        FId                  : Integer;
        Fidusuario           : Integer;
        FDescricao           : string;
        FDThrLancamento      : string;
        FDThrPrevisaoTermino : string;
        FDThrInicio          : string;
        FDThrFinalizada      : string;
        FStatus              : Integer;
      public
        property ID                  : Integer read FId                   write FID;
        property IDUsuario           : Integer read FIdUsuario            write Fidusuario;
        property Descricao           : String  read FDescricao            write FDescricao;
        property DThrLancamento      : string  read FDThrLancamento       write FDThrLancamento;
        property DThrPrevisaoTermino : string  read FDThrPrevisaoTermino  write FDThrPrevisaoTermino;
        property DThrInicio          : string  read FDThrInicio           write FDThrInicio;
        property DThrFinalizada      : string  read FDThrFinalizada       write FDThrFinalizada;
        property Status              : integer read FStatus               write FStatus;
    end;

implementation

end.
