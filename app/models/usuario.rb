class Usuario < ApplicationRecord
    self.table_name = "usuarios"
    has_secure_password #
    #validates :password, length: {minimum: 6}
    before_save :downcase_attribures
    validates :nombre, presence: true
    validates :password , length: { minimum: 8, message: " debe tener al menos 8 caracteres" }

    private
        # Método para pasar en minusculas los datos que nos interesan a la base de datos
        def downcase_attribures
            self.nombre = nombre.downcase
        end
end
 