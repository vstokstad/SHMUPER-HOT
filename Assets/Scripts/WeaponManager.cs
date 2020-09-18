using System.Collections.Generic;
using UnityEngine;
using Debug = System.Diagnostics.Debug;

public class WeaponManager : MonoBehaviour {
    public interface IWeapon {
        void Shoot();
    }

    #region PlasmaShotWeaponType

    public class PlasmaShot : MonoBehaviour, IWeapon {
        private readonly string _plasma = "PlasmaBall";
        
        private Vector3 _plasmaVelocity;
        private PlayerData _playerData;
        private PlayerController _playerController;
        private float _shootTimer = 0.1f;
        private GameObject _plasmaShot;


        private void Awake(){
            _playerController = GetComponent<PlayerController>();
            _playerData = _playerController.playerData;
          



        }

        public void Shoot(){
            if (!(_shootTimer <= 0f)) {
                _shootTimer -= Time.unscaledDeltaTime;
                return;
            }
            _shootTimer = 0.1f;
            if (_playerData.plasmaAmmunition <= 0) return;
            _plasmaShot  = Instantiate(Resources.Load(_plasma, typeof(GameObject))) as GameObject;
            _plasmaShot.SetActive(true);
            Vector3 initialPosition = gameObject.transform.position;
            initialPosition.x += 1f;
            _plasmaShot.transform.position = initialPosition;
            _plasmaShot.SetActive(true);
            _plasmaVelocity.x = 15f;
            _plasmaVelocity.y = 0f;
            _plasmaShot.GetComponent<Rigidbody>().velocity = _plasmaVelocity;
            _playerData.plasmaAmmunition -= 1;
        }
    }




    #endregion

    #region LaserWeaponType

    public class LaserBeam : MonoBehaviour, IWeapon {
        private PlayerData _playerData;
        private LaserBeamControl _laserBeamControl;
        private GameObject _laserBeam;
        private float _laserLengthOn = 30f;
        private float _laserLengthOff = 0f;
        private Vector3 _laserScale;
        private Collider _laserCollider;
        private string _laserBeamString = "LaserBeam";
        private bool _laserIsOn;

        private void Awake(){
            _laserBeam = Instantiate(Resources.Load(_laserBeamString, typeof(GameObject)), transform) as GameObject;
            _playerData = GetComponent<PlayerController>().playerData;
            _laserBeamControl = GetComponent<LaserBeamControl>();
            _laserCollider = _laserBeam.GetComponent<Collider>();
            _laserScale.z = _laserLengthOff;
            _laserBeam.transform.localScale = _laserScale;
            _laserCollider.enabled = false;
            _laserIsOn = false;
        }

        private void Update(){
            if (_laserIsOn) _playerData.laserAmmunition -= Time.unscaledDeltaTime;
            if (_playerData.laserAmmunition <= 0f) {
                _laserScale.z = _laserLengthOff;
                _laserBeam.transform.localScale = _laserScale;
                _laserCollider.enabled = false;
                _laserIsOn = false;
            }
        }

        private void OnDisable(){
            Destroy(_laserBeam);
        }

        public void Shoot(){
            if (_playerData.laserAmmunition < 1f) return;
            if (_playerData.laserAmmunition > 0f) {
                _laserIsOn = true;
                _laserScale.z = _laserLengthOn;
                _laserBeam.transform.localScale = _laserScale;
                _laserBeamControl.enabled = true;
                _laserCollider.enabled = true;
            }
        }


        #endregion

        #region HomingMissileWeaponType

        #endregion
    }
}