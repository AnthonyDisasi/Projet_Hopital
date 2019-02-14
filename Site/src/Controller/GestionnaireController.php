<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;


/**
 * Class GestionnaireController
 * @package App\Controller
 *
 * @Route("/gestionnaire")
 */
class GestionnaireController extends AbstractController
{
    /**
     * @return Response
     * @Route("/", name="gestionnaire")
     *
     */
    public function indexAction(Request $request) {

        return $this->render('Gestionnaire/gestionnaire.html.twig');

    }

}