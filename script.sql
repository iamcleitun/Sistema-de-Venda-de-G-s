-- MySQL Script generated by MySQL Workbench
-- Wed Aug  7 08:56:08 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuário` (
  `idUsuário` INT NOT NULL,
  `login_usuario` VARCHAR(45) NULL,
  `senha_usuario` INT(10) NULL,
  PRIMARY KEY (`idUsuário`),
  UNIQUE INDEX `login_usuario_UNIQUE` (`login_usuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cartão`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cartão` (
  `idCartão` INT NOT NULL,
  `validade_cartão` VARCHAR(5) NULL,
  `numero_cartao` INT(12) NULL,
  `cvv` INT(3) NULL,
  PRIMARY KEY (`idCartão`),
  UNIQUE INDEX `validade_cartão_UNIQUE` (`validade_cartão` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Usuário_idUsuário` INT NOT NULL,
  `Cartão_idCartão` INT NOT NULL,
  `cpf_cliente` INT(11) NOT NULL,
  `telefone_cliente` VARCHAR(16) NULL,
  `endereco_cliente` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `cpf_cliente_UNIQUE` (`cpf_cliente` ASC) VISIBLE,
  INDEX `fk_Cliente_Usuário_idx` (`Usuário_idUsuário` ASC) VISIBLE,
  UNIQUE INDEX `telefone_cliente_UNIQUE` (`telefone_cliente` ASC) VISIBLE,
  UNIQUE INDEX `endereco_cliente_UNIQUE` (`endereco_cliente` ASC) VISIBLE,
  INDEX `fk_Cliente_Cartão1_idx` (`Cartão_idCartão` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Usuário`
    FOREIGN KEY (`Usuário_idUsuário`)
    REFERENCES `mydb`.`Usuário` (`idUsuário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Cartão1`
    FOREIGN KEY (`Cartão_idCartão`)
    REFERENCES `mydb`.`Cartão` (`idCartão`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionário` (
  `idFuncionário` INT NOT NULL,
  `Usuário_idUsuário` INT NOT NULL,
  `nis_funcionario` INT(12) NOT NULL,
  PRIMARY KEY (`idFuncionário`),
  UNIQUE INDEX `nis_funcionario_UNIQUE` (`nis_funcionario` ASC) VISIBLE,
  INDEX `fk_Funcionário_Usuário1_idx` (`Usuário_idUsuário` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionário_Usuário1`
    FOREIGN KEY (`Usuário_idUsuário`)
    REFERENCES `mydb`.`Usuário` (`idUsuário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estoque_de_vasilhame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estoque_de_vasilhame` (
  `idestoque_de_vasilhame` INT NOT NULL,
  `Venda_idVenda` INT NOT NULL,
  `qtd_vasilhame` INT(3) NOT NULL,
  `Funcionário_idFuncionário` INT NOT NULL,
  PRIMARY KEY (`idestoque_de_vasilhame`, `Funcionário_idFuncionário`),
  INDEX `fk_estoque_de_vasilhame_Venda1_idx` (`Venda_idVenda` ASC) VISIBLE,
  INDEX `fk_estoque_de_vasilhame_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_de_vasilhame_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `mydb`.`Venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_de_vasilhame_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`Funcionário` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL,
  `Qtddproduto` INT(3) NOT NULL,
  `estoque_de_vasilhame_idestoque_de_vasilhame` INT NOT NULL,
  `Funcionário_idFuncionário` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `estoque_de_vasilhame_idestoque_de_vasilhame`, `Funcionário_idFuncionário`),
  INDEX `fk_Produto_estoque_de_vasilhame1_idx` (`estoque_de_vasilhame_idestoque_de_vasilhame` ASC) VISIBLE,
  INDEX `fk_Produto_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_estoque_de_vasilhame1`
    FOREIGN KEY (`estoque_de_vasilhame_idestoque_de_vasilhame`)
    REFERENCES `mydb`.`estoque_de_vasilhame` (`idestoque_de_vasilhame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`Funcionário` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `qtddestoque` INT(5000) UNSIGNED NULL,
  `preco_produto` DECIMAL(4,2) UNSIGNED NULL,
  `peso` INT NOT NULL,
  `validade_produto` DATE NULL,
  `fabricacao` DATE NULL,
  `Funcionário_idFuncionário` INT NOT NULL,
  PRIMARY KEY (`idEstoque`, `Funcionário_idFuncionário`),
  INDEX `fk_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Estoque_Funcionário1_idx` (`Funcionário_idFuncionário` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_Funcionário1`
    FOREIGN KEY (`Funcionário_idFuncionário`)
    REFERENCES `mydb`.`Funcionário` (`idFuncionário`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venda` (
  `idVenda` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `dataencomenda` DATE NULL,
  `horaencomenda` DATE NULL,
  `dataentrega` DATE NULL,
  `horaentrega` DATE NULL,
  `valor_venda` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idVenda`),
  INDEX `fk_Venda_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
