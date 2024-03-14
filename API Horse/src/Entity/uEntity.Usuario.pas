unit uEntity.Usuario;

interface

      type
      TEntityUsuario = class
        private
          FNome: string;
          FPass: string;
          FLogin: string;

        public
          property Nome   : string read FNome  write FNome;
          property Longin : string read FLogin write FLogin;
          property Pass   : string read FPass  write FPass;
      end;


implementation

end.
