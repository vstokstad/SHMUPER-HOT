using Actors.Enemies;
using UnityEngine;
using static Managers.TagsAsStrings;

namespace Actors.Weapons {
    public class MissileControl : MonoBehaviour {
        [SerializeField] private float missileDamage = 0.8f;
        [SerializeField] private float speed = 20f;
        private Vector3 _moveDirection;
        private Rigidbody _rigidBody;
    
        [SerializeField]  private float enemySearchRate = 0.5f;
        private float _searchForTargetTimer;

        private void Awake(){
            _rigidBody = GetComponent<Rigidbody>();
            gameObject.SetActive(true);
            _searchForTargetTimer = enemySearchRate;
        }

        private void FixedUpdate(){
            _searchForTargetTimer -= Time.fixedDeltaTime;
            if (_searchForTargetTimer <= 0f) {
                _searchForTargetTimer = !SearchForEnemy() ? enemySearchRate : 1f;
            }
            _moveDirection.Normalize();
            Vector3 velocity = _rigidBody.velocity + _moveDirection * (speed * Time.fixedDeltaTime);
            velocity = Vector3.ClampMagnitude(velocity, 10f);
            _rigidBody.velocity = velocity;
      
        }

        private void OnEnable(){
            _searchForTargetTimer = enemySearchRate;
            SearchForEnemy();
            _rigidBody = GetComponent<Rigidbody>();
            _rigidBody.velocity = Vector3.right;
            gameObject.SetActive(true);
        }

        private void OnDisable(){
            WeaponPool.Instance.ReturnToPool(WeaponType.Missile, gameObject);
        }

        private void OnBecameInvisible(){
            gameObject.SetActive(false);
        }

        private void OnTriggerEnter(Collider other){
            if (!other.CompareTag(enemyTag)) return;
            other.GetComponent<EnemyController>().TakeDamage(missileDamage);
            gameObject.SetActive(false);
        }

        private bool SearchForEnemy(){
            Collider[] hitColliders = new Collider[20];
            int numColliders = Physics.OverlapSphereNonAlloc(transform.position, 20f, hitColliders);
            for (int i = 0; i < numColliders; i++) {
                if (!hitColliders[i].CompareTag(enemyTag)) continue;
                Vector3 enemyPos = hitColliders[i].transform.position;
                _moveDirection = enemyPos - transform.position;
                return true;
            }

            return false;
        }
    }
}