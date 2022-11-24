<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SimuladorController extends Controller
{
    private $dadosSimulador;
    private $simulacao = [];

    public function simular(Request $request)
    {
        $this->carregarArquivoDadosSimulador() 
             ->filtrarConvenio($request->convenios)
             ->filtrarParcelas($request->parcelas)
             ->simularEmprestimo($request->valor_emprestimo)             
             ->filtrarInstituicao($request->instituicoes)
        ;
        return \response()->json($this->simulacao);
    }

    private function carregarArquivoDadosSimulador() : self
    {
        $this->dadosSimulador = json_decode(\File::get(storage_path("app/public/simulador/taxas_instituicoes.json")));
        return $this;
    }

    private function simularEmprestimo(float $valorEmprestimo) : self
    {
        foreach ($this->dadosSimulador as $dados) {
            $this->simulacao[$dados->instituicao][] = [
                "taxa"            => $dados->taxaJuros,
                "parcelas"        => $dados->parcelas,
                "valor_parcela"    => $this->calcularValorDaParcela($valorEmprestimo, $dados->coeficiente),
                "convenio"        => $dados->convenio,
            ];
        }
        return $this;
    }

    private function calcularValorDaParcela(float $valorEmprestimo, float $coeficiente) : float
    {
        return round($valorEmprestimo * $coeficiente, 2);
    }

    private function filtrarInstituicao(array $instituicoes) : self
    {
        if (\count($instituicoes))
        {
            $arrayAux = [];
            foreach ($instituicoes AS $key => $instituicao)
            {
                if (\array_key_exists($instituicao, $this->simulacao))
                {
                     $arrayAux[$instituicao] = $this->simulacao[$instituicao];
                }
            }
            $this->simulacao = $arrayAux;
        }
        return $this;
    }

    private function filtrarConvenio(array $convenios) : self
    {
        $arrayAux = [];
        if (\count($convenios))
        {
            foreach ($this->dadosSimulador AS $key => $dado)
            {             
                foreach ($convenios AS $key => $convenio)
                {
                    if($dado->convenio === $convenio) {                        
                        array_push($arrayAux, $dado);
                    }
                                                                                    
                }
            }            
            $this->dadosSimulador = $arrayAux;
        }

        return $this;
    }

    private function filtrarParcelas(int $parcela) : self
    {
        $arrayAux = []; 
        if ($parcela > 0)
        {       
            foreach ($this->dadosSimulador AS $key => $dado)
            {             
                if($dado->parcelas === $parcela) {                        
                    array_push($arrayAux, $dado);
                }
            }            
            $this->dadosSimulador = $arrayAux;
        }

        return $this;
    }
}
