using System;
using System.Collections.Generic;
using UnityEngine;

namespace Actors.Weapons {
    public class WeaponPool : MonoBehaviour {
        [SerializeField] private GameObject plasmaPrefab;
        [SerializeField] private GameObject laserPrefab;
        [SerializeField] private GameObject missilePrefab;
        private readonly Queue<GameObject> _laserQueue = new Queue<GameObject>(5);
        private readonly Queue<GameObject> _missileQueue = new Queue<GameObject>(20);
        private readonly Queue<GameObject> _plasmaQueue = new Queue<GameObject>(20);
        public static WeaponPool Instance { get; private set; }

        private void Awake(){
            Instance = this;
            AddWeapon(_plasmaQueue, plasmaPrefab, 10);
            AddWeapon(_laserQueue, laserPrefab, 1);
            AddWeapon(_missileQueue, missilePrefab, 10);
        }

        public GameObject Get(WeaponType currentWeapon){
            switch (currentWeapon) {
                case WeaponType.Plasma:
                    if (_plasmaQueue.Count == 0) AddWeapon(_plasmaQueue, plasmaPrefab, 1);

                    return _plasmaQueue.Dequeue();

                case WeaponType.Laser:
                    if (_laserQueue.Count == 0) AddWeapon(_laserQueue, laserPrefab, 1);

                    return _laserQueue.Dequeue();


                case WeaponType.Missile:
                    if (_missileQueue.Count == 0) AddWeapon(_missileQueue, missilePrefab, 1);

                    return _missileQueue.Dequeue();

                default:
                    if (_plasmaQueue.Count == 0) AddWeapon(_plasmaQueue, plasmaPrefab, 1);

                    return _plasmaQueue.Dequeue();
            }
        }

        private static void AddWeapon(Queue<GameObject> queue, GameObject weaponPrefab, int number){
            for (int i = 0; i < number; i++) {
                GameObject shot = Instantiate(weaponPrefab);
                shot.gameObject.SetActive(false);
                queue.Enqueue(shot);
            }
        }

        public void ReturnToPool(WeaponType weaponType, GameObject shot){
       
            switch (weaponType) {
                case WeaponType.Plasma:
                    _plasmaQueue.Enqueue(shot);
                    break;
                case WeaponType.Laser:
                    _laserQueue.Enqueue(shot);
                    break;
                case WeaponType.Missile:
                    shot.GetComponent<Rigidbody>().velocity = Vector3.zero;
                    _missileQueue.Enqueue(shot);
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(weaponType), weaponType, null);
            }
        }
    }
}