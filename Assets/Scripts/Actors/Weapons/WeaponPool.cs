using UnityEngine;

namespace Actors.Weapons {
    public class WeaponPool : MonoBehaviour {
        [SerializeField] private GameObject plasmaPrefab;
        [SerializeField] private GameObject laserPrefab;
        [SerializeField] private GameObject missilePrefab;
        [SerializeField] private Transform player;
        private readonly GameObject[] _laserQueue = new GameObject[2];
        private readonly GameObject[] _missileQueue = new GameObject[20];
        private readonly GameObject[] _plasmaQueue = new GameObject[20];
        public static WeaponPool Instance { get; private set; }

        private void Awake(){
            if(Instance != null) Destroy(Instance);
            Instance = this;
            AddWeapon(_plasmaQueue, plasmaPrefab, 15, player);
            AddWeapon(_laserQueue, laserPrefab, 2, player);
            AddWeapon(_missileQueue, missilePrefab, 10, player);
        }

        // ReSharper disable once UnusedMethodReturnValue.Local
        private GameObject CheckAvailableShot(GameObject[] shotArray){
            foreach (GameObject t in shotArray) {
                if (t.activeSelf) continue;
                return t;
            }

            throw new UnityException("No available shots right now");
        }

        public GameObject Get(WeaponType currentWeapon){
            switch (currentWeapon) {
                case WeaponType.Plasma:

                    return CheckAvailableShot(_plasmaQueue);


                case WeaponType.Laser:

                    return CheckAvailableShot(_laserQueue);


                case WeaponType.Missile:

                    return CheckAvailableShot(_missileQueue);


                default:

                    return CheckAvailableShot(_plasmaQueue);
            }
        }

        private static void AddWeapon(GameObject[] queue, GameObject weaponPrefab, int number, Transform parent){
            for (int i = 0; i < number; i++) {
                GameObject shot = Instantiate(weaponPrefab, parent);
                shot.gameObject.SetActive(false);
                queue[i] = shot;
            }
        }
    }
}