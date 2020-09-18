using UnityEngine;

public class MissileControl : MonoBehaviour {
    private readonly float _missileDamage = 1f;
    private readonly float _speed = 10f;
    private Vector3 _moveDirection;
    private Rigidbody _rigidBody;


    private void Awake(){
        _rigidBody = GetComponent<Rigidbody>();
        gameObject.SetActive(true);
    }

    private void FixedUpdate(){
        SearchForEnemy();
        _rigidBody.AddForce(_moveDirection * (_speed * Time.fixedDeltaTime), ForceMode.Force);
        _rigidBody.rotation = Quaternion.Euler(_moveDirection.x, _moveDirection.y, _moveDirection.z);
        transform.rotation = _rigidBody.rotation;
    }

    private void OnEnable(){
        _rigidBody = GetComponent<Rigidbody>();

        gameObject.SetActive(true);
        _moveDirection = Vector3.right * 10f;
    }

    private void OnDisable(){
        WeaponPool.Instance.ReturnToPool(WeaponType.Missile, gameObject);
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(_missileDamage);
        gameObject.SetActive(false);
    }

    private void SearchForEnemy(){
        Collider[] hitColliders = new Collider[10];
        int numColliders = Physics.OverlapSphereNonAlloc(transform.position, 20f, hitColliders);
        for (int i = 0; i < numColliders; i++) {
            if (!hitColliders[i].CompareTag("Enemy")) continue;
            Vector3 enemyPos = hitColliders[i].attachedRigidbody.position;
            _moveDirection = enemyPos - transform.position;
            return;
        }
    }
}