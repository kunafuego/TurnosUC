# frozen_string_literal: true

RSpec.describe Usuario, type: :request do
  before(:each) do
    # Aqui se utiliza la factory de usuarios, para crear uno
    @usuario = create(:usuario)
    sign_in @usuario
    @turno = create(:turno)
  end

  # Empiezan los test
  describe 'delete' do
    it 'deberia disminuir en 1 la cantidad de usuarios' do
      expect do
        delete usuarios_delete_path(id_usuario: @usuario.id, turno_id: @turno.id)
      end.to change(Usuario, :count).by(-1)
    end
  end
end
