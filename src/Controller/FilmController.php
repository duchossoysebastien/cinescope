<?php

namespace App\Controller;

use App\Repository\FilmRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class FilmController extends AbstractController
{
    #[Route('/film', name: 'app_film')]
    public function index(FilmRepository $fr): Response
    {
        $films = $fr->findAll();
        return $this->render('film/index.html.twig', [
            "films" => $films
        ]);
    }

    #[Route('/films/{id}', name: 'détail_film')]
    public function detail(FilmRepository $fr,int $id): Response
    {
        $film = $fr->find($id);
        return $this->render('film/detail.html.twig', [
            "film" => $film
        ]);
    }
}
