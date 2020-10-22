using UnityEngine;

namespace Actors.Weapons {
    public class WeaponPool : MonoBehaviour {
        [SerializeField] private GameObject plasmaPrefab;
        [SerializeField] private GameObject laserPrefab;
        [SerializeField] private GameObject missilePrefab;
        private readonly GameObject[] _laserQueue = new GameObject[2];
        private readonly GameObject[] _missileQueue = new GameObject[20];
        private readonly GameObject[] _plasmaQueue = new GameObject[20];
        public static WeaponPool Instance { get; private set; }

        private void Awake(){
            Instance = this;
            AddWeapon(_plasmaQueue, plasmaPrefab, 20, Instance.transform);
            AddWeapon(_laserQueue, laserPrefab, 2, Instance.transform);
            AddWeapon(_missileQueue, missilePrefab, 20, Instance.transform);
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

                    CheckAvailableShot(_plasmaQueue);

                    break;

                case WeaponType.Laser:

                    CheckAvailableShot(_laserQueue);
                    break;


                case WeaponType.Missile:

                    CheckAvailableShot(_missileQueue);
                    break;

                default:

                    CheckAvailableShot(_plasmaQueue);
                    break;
            }

            throw new UnityException("No available shots right now");
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