let login = (usuario, contrasena) => {
  // verifico si existe el usuario
  return userModel
    .findOne({
      where: {
        [Op.or]: [{ user: usuario }, { mail: usuario }],
      },
    })
    .then((resultado) => {
      if (resultado) {
        return bcrypt.compare(contrasena, resultado.password).then((resul) => {
          if (resul) {
            if (resultado.discontinued == 0) {
              //  varUsuario.usuarioLogueado = resultado;
              const token = jwt.sign(
                { dataUser: resultado },
                process.env.JWT_SECRET,
                { expiresIn: 3600 }
              );
              //agrego para que lo guarde en una variable global para que no
              // este pidiendo en cada consulta
              varUsuario.token = token;
              return token;
            } else {
              throw "deshabilitado";
            }
          } else {
            return false;
          }
        });
      }
      return false;
    })
    .catch((error) => {
      return error;
    });
};
