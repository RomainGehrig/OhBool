{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module OhBool.Common where

import qualified Data.Map as M

data BinaryOperator = Or
                    | And
                    | Xor

type VarValue = Bool
newtype Var = Var Char deriving (Show,Ord,Eq)
type Vars = M.Map Var VarValue

getValue :: Var -> Vars -> Maybe VarValue
getValue = M.lookup

data Expression = BinaryExpression BinaryOperator Expression Expression
                | Not Expression
                | Variable Var
                | BoolChain BinaryOperator [Expression]
                | BoolValue Bool
