using System.Collections.Generic;
using UnityEngine;

public class WeaponPool : MonoBehaviour {
    [SerializeField] private GameObject plasmaPrefab;
    [SerializeField] private GameObject laserPrefab;
    [SerializeField] private GameObject missilePrefab;


    private readonly Queue<GameObject> _weaponQueue = new Queue<GameObject>();
    public static WeaponPool Instance { get; private set; }

    private void Awake(){
        Instance = this;
    }

    public GameObject Get(WeaponType currentWeapon){
        switch (currentWeapon) {
            case WeaponType.Plasma:
                if (_weaponQueue.Count < 10) AddWeapon(plasmaPrefab, 2);
                return _weaponQueue.Dequeue();

            case WeaponType.Laser:
                if (_weaponQueue.Count < 10) AddWeapon(laserPrefab, 1);
                return _weaponQueue.Dequeue();


            case WeaponType.HomingMissile:
                if (_weaponQueue.Count < 10) AddWeapon(missilePrefab, 1);
                return _weaponQueue.Dequeue();

            default:
                if (_weaponQueue.Count < 10) AddWeapon(plasmaPrefab, 2);
                return _weaponQueue.Dequeue();
        }
    }

    private void AddWeapon(GameObject weaponPrefab, int number){
        for (int i = 0; i < number; i++) {
            GameObject shot = Instantiate(weaponPrefab);
            shot.gameObject.SetActive(false);
            _weaponQueue.Enqueue(shot);
        }
    }

    public void ReturnToPool(GameObject shot){
        shot.gameObject.SetActive(false);
        _weaponQueue.Enqueue(shot);
    }
}