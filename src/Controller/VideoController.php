<?php

namespace App\Controller;

use App\Entity\Video;
use App\Form\SeachType;
use App\Form\VideoType;
use App\Model\SearchData;
use App\Repository\VideoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

use Knp\Component\Pager\PaginatorInterface;
#[Route('/')]
class VideoController extends AbstractController
{
    #[Route('/', name: 'app_home', methods: ['GET'])]
    public function index(VideoRepository $videoRepository, Request $request , PaginatorInterface $paginator): Response
    {  
        if ($this->getUser()){
            if (!$this->getUser()->isVerified()){
                $this->addFlash('info', "Votre adresse e-mail n'est pas vérifiée.");
            }  
        }
        $pagination = $paginator->paginate(
            $videoRepository->paginationQuery(),
            $request->query->get('page',1),
            9
         );
         $search = false ; 

     $searchData= new SearchData();
     $form = $this->createForm(SeachType::class,$searchData);
     $form->handleRequest($request);

     if($form->isSubmitted() && $form->isValid()){
    $searchData->page = $request->query->getInt('page', 1);
    // $video= $videoRepository->findBySearch($searchData);
    //    dd($video);
 
    $pagination = $paginator->paginate(
        $videoRepository->findbySearch($searchData),
        $request->query->get('page', 1),
         9 
    );
    $search = true;

    return $this->render('video/index.html.twig',[
        'form' => $form,
        'pagination' => $pagination,
        'search' => $search,
        'searchTerm' => $searchData->query, 
       
        'videos' => $videoRepository->findBySearch($searchData)
    ]);
     }
        return $this->render('video/index.html.twig',[
          'form'=>$form->createView(),
            'pagination' => $pagination,
            'search' => $search,
        ]);
    }

    #[Route('/video/create', name: 'app_video_create', methods: ['GET', 'POST'])]
    public function new(Request $request, VideoRepository $videoRepository): Response
    {
        if ($this->getUser()){
            if ($this->getUser()->isVerified() == false ) {
                $this->addFlash('error', 'Vous devez confirmer votre e-mail pour créer la vidéo !');
                return $this->redirectToRoute('app_home');
            } 
        }else{
            $this->addFlash('error', 'Vous devez vous connecter pour créer une vidéo!');
            return $this->redirectToRoute('app_login');
        }
         
        $video = new Video();
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUser($this->getUser());
            $premiumVideo = $form->get('premiumVideo')->getData();
            $video->setPremiumVideo($premiumVideo);
            $videoRepository->save($video, true);
            // $videoRepository->flush();
            $this->addFlash('success', 'Vous  avez créé avec succès une nouvelle vidéo !');
            return $this->redirectToRoute('app_home');
        }
        
        return $this->renderForm('video/create.html.twig', [
            'video' => $video,
            'form' => $form,
            
        ]);
    }

    #[Route('/video/{id}', name: 'app_video_show', methods: ['GET'])]
    public function show(Video $video): Response
    {        if ($video->isPremiumVideo() && (!$this->getUser() || !$this->getUser()->isVerified())) {
         $this->addFlash("error","Vous n'êtes pas autorisé à visionner cette vidéo premium.");
        return $this->redirectToRoute('app_login');
    }
        return $this->render('video/show.html.twig', [
            'video' => $video,
        ]);
    }

    #[Route('/video/{id<[0-9]+>}/edit', name: 'app_video_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    {   if ($this->getUser()) {
        if ($this->getUser()->isVerified() == false) {
            $this->addFlash('error', 'Vous devez confirmer votre email pour éditer la vidéo!');
            return $this->redirectToRoute('app_home');
        } else if ($video->getUser()->getEmail() !== $this->getUser()->getEmail()) {
            $this->addFlash('error', "Vous devez être l'utilisateur " . $video->getUser()->getFirstname() . ' pour éditer cette vidéo !');
            return $this->redirectToRoute('app_home');
        }
    } else {
        $this->addFlash('error', 'Vous devez vous connecter pour éditer cette vidéo!');
        return $this->redirectToRoute('app_login');
    }
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();
            $this->addFlash('success', 'Vous avez modifié la vidéo avec succès!');
            return $this->redirectToRoute('app_home');
        }

        return $this->renderForm('video/edit.html.twig', [
            'video' => $video,
            'form' => $form->createView()
        ]);
    }

    #[Route('/{id}', name: 'app_video_delete', methods: ['POST'])]
    public function delete(Request $request, Video $video, EntityManagerInterface $entityManager): Response
    {  if ($this->getUser()) {
        if ($this->getUser()->isVerified() == false) {
            $this->addFlash('error', 'Vous devez confirmer votre email pour supprimer la vidéo!!');
            return $this->redirectToRoute('app_home');
        } else if ($video->getUser()->getEmail() !== $this->getUser()->getEmail()) {
            $this->addFlash('error', "Vous devez être l'utilisateur " . $video->getUser()->getFirstname() . ' pour supprimer cette vidéo  !');
            return $this->redirectToRoute('app_home');
        }
    } else {
        $this->addFlash('error', 'Vous devez vous connecter pour supprimer cette vidéo!');
        return $this->redirectToRoute('app_login');
    }
        
            $entityManager->remove($video);
            $entityManager->flush();
       
        $this->addFlash('info', 'Vous avez supprimé la vidéo avec succès!'); 
        return $this->redirectToRoute('app_home');
    }
}
