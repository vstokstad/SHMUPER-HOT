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
        private int _ammunition;
        private GameObject _plasmaShot;
        private List<GameObject> _plasmaShots;
        private Vector3 _plasmaVelocity;
        private PlayerData _playerData;
        private Rigidbody _playerRigidBody;

        private void Awake(){
            _playerRigidBody = GetComponent<Rigidbody>();
            _playerData = GetComponent<PlayerController>().playerData;
            _ammunition = _playerData.plasmaAmmunition;
            _plasmaShots = new List<GameObject>();
            for (int i = 0; i < _ammunition; i++) {
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
                _plasmaVelocity.y = _playerRigidBody.velocity.y * 10f;
                shot.GetComponent<Rigidbody>().velocity = _plasmaVelocity;
                break;
            }
        }

        public void SecondShoot(){
            throw new NotImplementedException();
        }
    }

    #endregion
}