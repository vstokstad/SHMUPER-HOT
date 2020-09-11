using System;
using System.Collections.Generic;
using UnityEngine;

public class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
        void SecondShoot();
    }

    #region PlasmaShotWeaponType

    public class PlasmaShot : MonoBehaviour, IWeapon {
        private readonly string _plasma = "PlasmaBall";
        [NonSerialized] public int ammunition;

        private GameObject _plasmaShot;
        private List<GameObject> _plasmaShots;
        private Vector3 _plasmaVelocity;
        private PlayerData _playerData;

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

            if (ammunition > _playerData.plasmaAmmunition) {
                _plasmaShots.Add(Instantiate(Resources.Load(_plasma, typeof(GameObject))) as GameObject);
            }
        }

        public void SecondShoot(){
            throw new NotImplementedException();
        }
    }

    #endregion
}