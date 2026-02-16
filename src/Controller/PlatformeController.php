<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\PlatformeRepository;

final class PlatformeController extends AbstractController
{
    #[Route('/platforme', name: 'app_platforme')]
    public function index(PlatformeRepository $platformeRepository): Response
    {
        $platformes = $platformeRepository->findAll();
        return $this->render('platforme/index.html.twig', [
            'platformes' => $platformes,
        ]);
    }
}
