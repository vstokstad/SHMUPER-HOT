using UnityEngine;
using static TagsAsStrings;

public class MissileControl : MonoBehaviour {
    private readonly float _missileDamage = 0.3f;
    private readonly float _speed = 10f;
    private Vector3 _moveDirection;
    private Rigidbody _rigidBody;
    private AudioSource audioSource;


    private void Awake(){
        _rigidBody = GetComponent<Rigidbody>();
        gameObject.SetActive(true);
    }

    private void FixedUpdate(){
        SearchForEnemy();
        _rigidBody.AddForce(_moveDirection * (_speed * Time.fixedDeltaTime), ForceMode.Force);
        Quaternion rotation = Quaternion.Euler(_moveDirection.x, _moveDirection.y, _moveDirection.z);
        _rigidBody.MoveRotation(rotation);

        audioSource.panStereo = transform.position.normalized.x;
    }

    private void OnEnable(){
        _rigidBody = GetComponent<Rigidbody>();
        gameObject.SetActive(true);
        _moveDirection = transform.position * 1.1f;
        audioSource = GetComponent<AudioSource>();
    }

    private void OnDisable(){
        WeaponPool.Instance.ReturnToPool(WeaponType.Missile, gameObject);
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag(enemyTag)) return;
        other.GetComponent<EnemyController>().TakeDamage(_missileDamage);
        gameObject.SetActive(false);
    }

    private void SearchForEnemy(){
        Collider[] hitColliders = new Collider[10];
        int numColliders = Physics.OverlapSphereNonAlloc(transform.position, 10f, hitColliders);
        for (int i = 0; i < numColliders; i++) {
            if (!hitColliders[i].CompareTag(enemyTag)) continue;
            Vector3 enemyPos = hitColliders[i].attachedRigidbody.position;
            _moveDirection = enemyPos - transform.position;
            return;
        }
    }
}