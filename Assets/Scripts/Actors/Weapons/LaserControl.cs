using Actors.Enemies;
using UnityEngine;
using static Managers.TagsAsStrings;

namespace Actors.Weapons {
    public class LaserControl : MonoBehaviour {
        private readonly float _laserDamage = 0.1f;
        private readonly float _laserLengthOff = 0f;
        private readonly float _laserLengthOn = 20f;
        private Collider _laserCollider;
        private bool _laserIsOn;
        private Vector3 _laserScale;
        private float _laserTimer;
        private Transform _playerTransform;
        [SerializeField] private float laserTime = 0.8f;

        private void Awake(){
            _playerTransform = GameObject.FindWithTag(playerTag).transform;
            transform.position = _playerTransform.position;
            gameObject.SetActive(true);
            _laserTimer = laserTime;
        }

        public void Update(){
            transform.position = _playerTransform.position;
            if (_laserIsOn) _laserTimer -= Time.deltaTime;
            if (_laserTimer <= 0f) {
                gameObject.SetActive(false);
            }
        }

        private void OnEnable(){
            _laserScale.z = _laserLengthOn;
            gameObject.transform.localScale = _laserScale;
            _laserIsOn = true;
            _laserTimer = laserTime;
            gameObject.SetActive(true);
        }

        private void OnDisable(){
            _laserScale.z = _laserLengthOff;
            GameObject o = gameObject;
            o.transform.localScale = _laserScale;
            _laserIsOn = false;
        }

        private void OnTriggerStay(Collider other){
            if (other.gameObject.CompareTag(spaceJunkTag))
                if (other.transform.localScale.magnitude > 0.5f)
                    other.transform.localScale -= Vector3.one * Time.deltaTime;

            if (!other.gameObject.CompareTag(enemyTag)) return;
            other.GetComponent<EnemyController>().TakeDamage(_laserDamage);
        }
    }
}