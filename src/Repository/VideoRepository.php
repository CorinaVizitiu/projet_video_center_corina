<?php

namespace App\Repository;

use App\Entity\Video;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

use App\Model\SearchData;
/**
 * @extends ServiceEntityRepository<Video>
 *
 * @method Video|null find($id, $lockMode = null, $lockVersion = null)
 * @method Video|null findOneBy(array $criteria, array $orderBy = null)
 * @method Video[]    findAll()
 * @method Video[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class VideoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Video::class);
    }
    public function save(Video $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Video $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

  
   public function paginationQuery()
   {
       return $this->createQueryBuilder('v')
          ->orderBy('v.id', 'ASC')
          ->getQuery()
        ;
   }
       /**
     * Get published posts thanks to Search data value 
     * 
     * @param SearchData $searchData
     * @return PaginationInterface
     */ 
 public function findBySearch(SearchData $searchData){
    $video = $this->createQueryBuilder('v')
          ->addOrderBy('v.createdAt','DESC');

           if(!empty($searchData->query)) {
            $video = $video
            ->andWhere('v.title LIKE :query')
            ->orWhere('v.description LIKE :query')
            ->setParameter('query', '%' . $searchData->query . '%');;
           }
           $video = $video
           ->getQuery() ;
        //   ->getResult();

         return $video;
 }




//    public function findOneBySomeField($value): ?Video
//    {
//        return $this->createQueryBuilder('v')
//            ->andWhere('v.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
