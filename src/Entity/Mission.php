<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass="App\Repository\MissionRepository")
 * @ORM\Table(indexes={
 *     @ORM\Index(name="mission_start_end_idx", columns={"start", "end"}),
 * })
 */
class Mission
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer", options={"unsigned": true})
     */
    public ?int $id = null;

    /**
     * @ORM\Column
     * @Assert\NotBlank
     */
    public string $name = '';

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\Organization")
     * @Assert\NotNull
     */
    public ?Organization $organization = null;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\MissionType")
     */
    public ?MissionType $type = null;

    /**
     * @ORM\Column(type="datetimetz_immutable", nullable=true)
     */
    public ?\DateTimeImmutable $start = null;

    /**
     * @ORM\Column(type="datetimetz_immutable", nullable=true)
     * @Assert\GreaterThan(propertyPath="start")
     */
    public ?\DateTimeImmutable $end = null;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\User")
     */
    public Collection $users;

    /**
     * @ORM\ManyToMany(targetEntity="App\Entity\CommissionableAsset")
     */
    public Collection $assets;

    public function __construct()
    {
        $this->users = new ArrayCollection();
        $this->assets = new ArrayCollection();
    }
}
