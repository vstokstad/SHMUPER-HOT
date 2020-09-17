using System;
using System.Collections.Generic;
using UnityEngine;

public class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
    }

    #region PlasmaShotWeaponType

    public class PlasmaShot : MonoBehaviour, IWeapon {
        private readonly string _plasma = "PlasmaBall";

        private GameObject _plasmaShot;
        private List<GameObject> _plasmaShots;
        private Vector3 _plasmaVelocity;
        private PlayerData _playerData;
        private float _shootTimer = 0.1f;
        [NonSerialized] public int ammunition;

        private void Awake(){
            _playerData = GetComponent<PlayerController>().playerData;
            ammunition = _playerData.plasmaAmmunition;
            _plasmaShots = new List<GameObject>();
            for (int i = 0; i < ammunition; i++) {
                _plasmaShots.Add(
                    Instantiate(Resources.Load(_plasma, typeof(GameObject))) as GameObject);
                _plasmaShots[i].SetActive(false);
            }
        }

        public void Shoot(){
            if (!(_shootTimer <= 0f)) {
                _shootTimer -= Time.deltaTime;
                return;
            }

            _shootTimer = 0.1f;

            Vector3 initialPosition = transform.position;
            initialPosition.x += 1f;
            foreach (GameObject shot in _plasmaShots) {
                if (shot.activeSelf) continue;
                shot.SetActive(true);
                shot.transform.position = initialPosition;
                _plasmaVelocity.x = 10f;
                _plasmaVelocity.y = 0f;
                shot.GetComponent<Rigidbody>().velocity = _plasmaVelocity;
                break;
            }


            if (ammunition == _playerData.plasmaAmmunition || ammunition > 15) return;
            _playerData.plasmaAmmunition = ammunition;
            _plasmaShots.Add(Instantiate(Resources.Load(_plasma, typeof(GameObject))) as GameObject);
            int count = _plasmaShots.Count - 1;
            _plasmaShots[count].transform.position = initialPosition;
            _plasmaShots[count].SetActive(false);
        }
    }

    #endregion

    #region LaserWeaponType

    public class LaserBeam : MonoBehaviour, IWeapon {
        private readonly string _laser = "LaserBeam";

        private GameObject _laserBeam;


        private PlayerData _playerData;
        [NonSerialized] public float ammunition;


        private void Awake(){
            _playerData = GetComponent<PlayerController>().playerData;
            ammunition = _playerData.laserAmmunition;
            _laserBeam = (GameObject) Instantiate(Resources.Load(_laser, typeof(GameObject)));
            _laserBeam.SetActive(true);
        }


        public void Shoot(){
            if (ammunition <= 0f) return;
            Vector3 transformLocalScale = _laserBeam.transform.localScale;
            while (ammunition > 0f) {
                transformLocalScale.x += 10f * Time.fixedDeltaTime;
                _laserBeam.transform.localScale = transformLocalScale;
                ammunition -= Time.fixedDeltaTime;
            }

            if (ammunition <= 0f) {
                transformLocalScale.x = 0f;
                _laserBeam.transform.localScale = transformLocalScale;
            }
        }
    }

    #endregion

    #region HomingMissileWeaponType

    #endregion
}